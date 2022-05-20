Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

 
  #  post '/send_otp_code', as: 'user_send_otp_code', to: 'users#verify_otp_code'
  post 'users' => 'users#create' 
  resources :users, only: [:create, :update]

  post '/send_otp', to: 'users#send_otp'
  post '/verify_otp', to: 'users#verify_otp'
  get  '/pan', to: 'users#pan'
  post  '/pan', to: 'users#pan'
  post '/aadhar_verify', to: 'users#aadhar_verify'
  post '/facematch', to: 'users#facematch'
  get '/kyc_verified', to: 'users#kyc_verified'
end
