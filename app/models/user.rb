class User < ApplicationRecord
	has_one :api_token
  has_one :kyc
  
end
