# require 'rest-client'
require 'uri'
require 'net/http'
class Kyc < ApplicationRecord
     belongs_to :user
  
  def self.doc_verify front_part, should_verify  
    url = URI("https://ext.digio.in:444/v3/client/kyc/analyze/file/idcard/")
    authorization = ENV['AUTHORIZATION']
    http = Net::HTTP.new(url.host, url.port);
    http.use_ssl = true
    request = Net::HTTP::Post.new(url)
    request["Auth"] = "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxNSwiZXhwIjoxNjUzMjE3Mjk3fQ.ozeJUyeeeOayQNVexpJOWX3a54-sJ_p1D9Voxk5_O7U"
    request["Authorization"] = authorization
    form_data = [['front_part', front_part], ['should_verify', should_verify]]
    request.set_form form_data, 'multipart/form-data'
    response = http.request(request)
    doc_response = response.code
  end
  
  
  def self.facematch file_1, file_2
    url = URI("https://ext.digio.in:444/v3/client/kyc/facematch")
    authorization = ENV['AUTHORIZATION']
    http = Net::HTTP.new(url.host, url.port);
    http.use_ssl = true
    request = Net::HTTP::Post.new(url)
    request["Auth"] = "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxNSwiZXhwIjoxNjUzMjE3Mjk3fQ.ozeJUyeeeOayQNVexpJOWX3a54-sJ_p1D9Voxk5_O7U"
    request["Authorization"] = ENV['AUTHORIZATION']
    form_data = [['file1', file_1], ['file2', file_2]]
    request.set_form form_data, 'multipart/form-data'
    response = http.request(request)
    facematch_response = response.code
  end

end
