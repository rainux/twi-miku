DataMapper.setup(:default, 'sqlite:twi_miku.db')

class User
  include DataMapper::Resource
  property :id,                 Serial
  property :screen_name,        String
  property :password_sha1,      String, :default => ''
  property :oauth_token,        String
  property :oauth_token_secret, String
  property :created_at,         DateTime
end

DataMapper.auto_upgrade!
