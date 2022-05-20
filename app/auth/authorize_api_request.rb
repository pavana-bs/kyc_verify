class AuthorizeApiRequest
    def initialize(headers = {})
      @headers = headers
    end
  
    # Service entry point - return valid user object
    def call
      {
        user: user
      }
    end
  
   
  
    private
  
    attr_reader :headers
  
    def user
      # check if user is in the database
      # memoize user object
      @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
      if @user.api_token.try(:is_valid?, http_auth_header)
        @user
      else
        raise(
          ExceptionHandler::InvalidToken,
          ("#{Message.invalid_token}")
        )
      end
      # handle user not found
    rescue ActiveRecord::RecordNotFound => e
      # raise custom error
      raise(
        ExceptionHandler::InvalidToken,
        ("#{Message.invalid_token} #{e.message}")
      )
    rescue
      raise(
          ExceptionHandler::InvalidToken,
          ("#{Message.invalid_token}")
      )
    end
  
    # decode authentication token
    def decoded_auth_token
      @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
    end
  
    # check for token in `Authorization` header
    def http_auth_header
      if headers['Auth'].present?
        return headers['Auth'].split(' ').last
      end
      raise(ExceptionHandler::MissingToken, Message.missing_token)
    end
  
      # check for appkey in header
    # def http_auth_appkey
    #   if headers['AppKey'].present?
    #     if headers['AppKey'].split(' ').last == Rails.application.credentials.APP_KEY
    #       return true
    #     else 
    #       raise(ExceptionHandler::InvalidAppKey, Message.invalid_appkey)
    #     end  
    #   else
    #     raise(ExceptionHandler::MissingAppKey, Message.missing_appkey)
    #   end
    # end
  end