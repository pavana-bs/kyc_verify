class Message
    def self.not_found(record = 'record')
      "Sorry, #{record} not found."
    end
    
    def self.invalid_token
      'Invalid token'
    end
  
    def self.missing_token
      'Missing token'
    end
  
    def self.invalid_appkey
      'Invalid appkey'
    end
  
    def self.missing_appkey
      'Missing appkey'
    end
  
    def self.unauthorized
      'Unauthorized request'
    end
  
    def self.account_created
      'Account created successfully'
    end
  
    def self.account_updated
      'Account updated successfully'
    end
  
    def self.account_not_created
      'Account could not be created'
    end
  
    def self.expired_token
      'Sorry, your token has expired. Please login to continue.'
    end
  
    def self.expired_otp
      'Sorry, your otp has expired. Please login to continue.'
    end
  
    def self.token_creation_success_for_forgot_password
      'Token created successfully'
    end
  
    def self.password_reset_success
      'Password Reset was successful'
    end
  
    def self.entity_created(entity_type = 'Record')
      "#{entity_type} created successfully"
    end
  
    def self.entity_updated(entity_type = 'Record')
      "#{entity_type} details updated successfully"

  end