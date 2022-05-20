class GenOtp

    def self.send_otp_code(phone_number)
        account_sid = ENV['ACCOUNT_SID']
        auth_token = ENV['AUTH_TOKEN']
        twilio_phone_number = ENV['TWILIO_PHONE_NUMBER']
        otp = GenOtp.gen_otp
        @client = Twilio::REST::Client.new(account_sid, auth_token)
        response = @client.messages.create(:from => twilio_phone_number, :status_callback => "https://bisque-walrus-9409.twil.io/status_callback", :to => "+91#{phone_number}", :body => "verification code is #{otp}").fetch
        otp_sent = response.status
        puts "response status: #{otp_sent}"
        [otp_sent, otp]
    end    
    def self.gen_otp
        otp = SecureRandom.random_number(10000)
    end    
end    