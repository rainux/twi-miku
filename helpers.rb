helpers do
  def partial(name, options={})
    haml("_#{name}".to_sym, options.merge(:layout => false))
  end

  def protected!
    unless authorized?
      response['WWW-Authenticate'] = %(Basic realm="Darkness")
      throw(:halt, [401, "Not authorized\n"])
    end
  end

  def authorized?
    return true if @user
    @auth ||=  Rack::Auth::Basic::Request.new(request.env)
    @auth.provided? && @auth.basic? && @auth.credentials &&
      @auth.credentials.last && !@auth.credentials.last.empty?
  end

  def oauth_callback_url
    url = request.scheme + "://"
    url << request.host

    if request.scheme == 'https' && request.port != 443 ||
      request.scheme == 'http' && request.port != 80
      url << ":#{request.port}"
    end

    url << '/oauth_callback'
    url
  end
end
