# class VerificationsController < ApplicationController
#     def create 
#         account_sid = ENV['ACCOUNT_SID']
#         auth_token = ENV['AUTH_TOKEN']
#         service_sid = ENV['SERVICE_SID']
#         twilio_phone_number = ENV['TWILIO_PHONE_NUMBER']
#         current_user.verification_code = 1_000_000 + rand(10_000_000 - 1_000_000)
#         current_user.save
#         to = current_user.phone_number
#           if to[0] = "0"
#             to.sub!("0", '+91')
#           end
#         @client = Twilio::Client.new(account_sid, auth_token)
#         @client.account_sms_message.create(:from => twilio_phone_number, :to =>phone_number,
#         :body => "verification code is #{current_user.verification_code} ", :channel => 'sms')
#       end   
    
   
