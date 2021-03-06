DataMapper.setup(:default, ENV['DATABASE_URL'] || 'sqlite:twi-miku.db')

class User
  include DataMapper::Resource
  property :id,                 Serial
  property :twitter_user_id,    Integer,  :unique_index => true
  property :screen_name,        String,   :index => :credentials
  property :password_sha1,      String,   :index => :credentials, :default => ''
  property :oauth_token,        String
  property :oauth_token_secret, String
  property :created_at,         DateTime
end

DataMapper.auto_upgrade!
