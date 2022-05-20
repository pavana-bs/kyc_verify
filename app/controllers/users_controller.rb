class UsersController < ApplicationController
  before_action :set_user, only: [:pan, :aadhar_verify, :facematch, :kyc_verified]

  def send_otp
    response, otp = GenOtp.send_otp_code params["phone_number"]
    if response
      verification = Verification.find_or_create_by(phone_number: params["phone_number"])
      verification.update(otp_code: otp, sent_time: Time.now)
      render json: { status: 'success', data: { message: "Otp sent to given phone number"} }
    else
      render json: { status: 'failure', data: { message: "Otp not sent"} }
    end  
  end


  def verify_otp
    verification = Verification.find_by(phone_number: params["phone_number"])
    if verification.present?
      if verification.is_valid?(params["otp_code"])

      user = User.find_or_create_by(phone_number: params["phone_number"])
      debugger
      if user.kyc.pan_verification_response == "true" &&  user.kyc.adhar_verification_response == "true" &&  user.kyc.photo_verification_response == "true"
        puts "KYC verified successfully"  
      elsif user.kyc.pan_verification_response != "true"
        puts "PAN verification failed"
      elsif user.kyc.adhar_verification_response != "true"
        puts "Aadhar verification failed"
      elsif user.kyc.photo_verification_response != "true"
        puts "Photo verification failed"
      end
      token = JsonWebToken.encode(user_id: user.id)
      user.api_token ? user.api_token.save_token(token) : user.build_api_token.save_token(token)
      render json: {status: 'success',data:{ user: user, message: "Phone number Verified"},auth_token: token}
      else
        render json: { status: 'failure', data: { message: "token expired"} }
      end
    else 
      render json: { status: 'failure', data: { message: "enter valid phone"} }
    end
  end

  def pan
    doc_response = Kyc.doc_verify params['front_part'], params['should_verify']
    if doc_response == "200"
      Kyc.find_or_create_by(user_id: @user.id, phone_number: @user.phone_number, pan_verification_response: "true")
      render json: { status: 'success', data: { message: "pan verified"} }
    else
      render json: { status: 'failure', data: { message: "pan not verified"} }  
    end  
  end  

  def aadhar_verify
    doc_response = Kyc.doc_verify params['front_part'], params['should_verify']
    if doc_response == "200"
      Kyc.update(user_id: @user.id, phone_number: @user.phone_number, adhar_verification_response: "true")
      render json: { status: 'success', data: { message: "aadhar verified"} }
    else
      render json: { status: 'failure', data: { message: "aadhar not verified"} }  
    end
  end
  
   def facematch 
    facematch_response = Kyc.facematch params["file_1"], params["file_2"]
    if facematch_response == "200"
      Kyc.update(user_id: @user.id,phone_number: @user.phone_number, photo_verification_response: "true")
      render json: { status: 'success', data: { message: "photo verified"} }
    else
      render json: { status: 'failure', data: { message: "photo not verified"} }  
    end
   end  

   def kyc_verified
    if @user.kyc.pan_verification_response == "true" &&  @user.kyc.adhar_verification_response == "true" &&  @user.kyc.photo_verification_response == "true"
      render json: { status: 'success', data: { message: "KYC verified successfully"} }
    else
      render json: { status: 'failure', data: { message: "KYC verification failed"} }
    end
   end 


  def update
    if @current_user.update user_params
      json_response(user: serialize_data(@current_user))
    else
      json_error_response @user.errors.full_messages
    end
  end



private

  def set_user
    @user = User.find_by(params["phone_number"])
  end

  def user_params
    params.require(:user).permit(:name, :email, :country_code, :phone_number)
  end

end  


