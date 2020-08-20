require 'net/http'
require 'open-uri'
require 'json'
 
class GetPrograms
 
    URL = "http://data.cityofnewyork.us/resource/uvks-tn5n.json"
   
    def get_programs
      uri = URI.parse(URL)
      response = Net::HTTP.get_response(uri)
      response.body
    end
   
  end     #ends class
   
  programs = GetPrograms.new.get_programs
  #puts programs


  url = URI("https://alpha-vantage.p.rapidapi.com/query?symbol=TSLA&function=GLOBAL_QUOTE")

  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  
  request = Net::HTTP::Get.new(url)
  request["x-rapidapi-host"] = 'alpha-vantage.p.rapidapi.com'
  request["x-rapidapi-key"] = 'b629a43ff0msh128b21c6bcd2d9cp1d32a1jsn84966b99aeea'
  
  response = http.request(request)
  j = JSON.parse(response.body)
puts j 
puts j["Global Quote"]["01. symbol"]

  #puts response.body