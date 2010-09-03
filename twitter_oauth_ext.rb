module TwitterOAuth
  class Client
    def get_raw(path, headers = {})
      headers.merge!('User-Agent' => "twitter_oauth gem v#{TwitterOAuth::VERSION}")
      oauth_response = access_token.get(path, headers)
      oauth_response.body
    end

    def post_raw(path, body = '', headers = {})
      headers.merge!('User-Agent' => "twitter_oauth gem v#{TwitterOAuth::VERSION}")
      oauth_response = access_token.post(path, body, headers)
      oauth_response.body
    end

    def delete_raw(path, headers = {})
      headers.merge!('User-Agent' => "twitter_oauth gem v#{TwitterOAuth::VERSION}")
      oauth_response = access_token.delete(path, headers)
      oauth_response.body
    end
  end
end
