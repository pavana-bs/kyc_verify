class ApplicationController < ActionController::API
   include Response
   include ExceptionHandler
#   # called before every action on controllers
  before_action :authorize_request, except: [:send_code, :create, :send_otp, :verify_otp, :pan, :aadhar_verify, :facematch, :kyc_verified]
  
  attr_reader :current_user
  
#   # Check for valid request token and return user
  def authorize_request
    @current_user = (AuthorizeApiRequest.new(request.headers).call)[:user]
  end

  def serialize_data data
    ActiveModel::SerializableResource.new(data).as_json
  end

end