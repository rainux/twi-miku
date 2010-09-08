#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'
Bundler.require
require 'twitter_oauth_ext'
require 'model'
require 'helpers'

configure do
  set :root, File.dirname(__FILE__)
  set :sessions, true
  use Rack::Flash
  use Rack::Deflater
  @@config = Hashie::Mash.new(YAML.load_file('config.yml'))
end

before do
  if session[:user_id]
    @user = User.get(session[:user_id])

  elsif authorized?
    @user = User.first(
      :screen_name.like => @auth.credentials.first,
      :password_sha1 => Digest::SHA1.hexdigest(@auth.credentials.last)
    )

    unless @user
      response['WWW-Authenticate'] = %(Basic realm="Darkness")
      throw(:halt, [401, "Not authorized\n"])
    end
  end

  @client = TwitterOAuth::Client.new(
    :consumer_key => @@config.consumer_key,
    :consumer_secret => @@config.consumer_secret,
    :token => (@user.oauth_token rescue nil),
    :secret => (@user.oauth_token_secret rescue nil)
  )
end

get '/' do
  redirect '/timeline' if @user
  haml :home
end

get '/timeline' do
  @rate_limit_status = @client.rate_limit_status
  @tweets = @client.home_timeline
  haml :timeline
end

post '/update_password' do
  @user.password_sha1 = Digest::SHA1.hexdigest(params[:password])
  @user.save
  flash[:notice] = 'Password saved successfully'
  redirect '/'
end

post '/update_status' do
  @client.update(params[:status])
  redirect '/timeline'
end

get '/connect' do
  request_token = @client.request_token(
    :oauth_callback => oauth_callback_url
  )
  session[:request_token] = request_token.token
  session[:request_token_secret] = request_token.secret
  redirect request_token.authorize_url
end

get '/oauth_callback' do
  # Exchange the request token for an access token.
  begin
    @access_token = @client.authorize(
      session[:request_token],
      session[:request_token_secret],
      :oauth_verifier => params[:oauth_verifier]
    )
  rescue OAuth::Unauthorized
  end

  if @client.authorized?
    account = Hashie::Mash.new(@client.info)
    @user = User.first_or_create(:twitter_user_id => account.id)
    @user.update(
      :screen_name => account.screen_name,
      :oauth_token => @access_token.token,
      :oauth_token_secret => @access_token.secret
    )

    session[:user_id] = @user.id

    redirect '/timeline'
  else
    redirect '/'
  end
end

get '/disconnect' do
  session[:user_id] = nil
  session[:request_token] = nil
  session[:request_token_secret] = nil
  redirect '/'
end

get %r{^/.*?\.(.+)$} do |format|
  protected!
  begin
    content_type format, :charset => 'utf-8'
    @client.get_raw(request.fullpath)
  rescue
    p $!
  end
end

post %r{^/.*?\.(.+)$} do |format|
  protected!
  begin
    content_type format, :charset => 'utf-8'
    params.delete('captures')
    @client.post_raw(request.fullpath, params)
  rescue
    p $!
  end
end
