require 'net/http'
require 'open-uri'
require 'json'

 
class GetProgram
  # "01. symbol": "TSLA",
  # "02. open": "1865.0000",
  # "03. high": "1911.0000",
  # "04. low": "1841.2100",
  # "05. price": "1878.5300",
  # "06. volume": "12205331",
  # "07. latest trading day": "2020-08-19",
  # "08. previous close": "1887.0900",
  # "09. change": "-8.5600",
  # "10. change percent": "-0.4536%"

    url = URI("https://alpha-vantage.p.rapidapi.com/query?symbol=TSLA&function=GLOBAL_QUOTE")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    
    request = Net::HTTP::Get.new(url)
    request["x-rapidapi-host"] = 'alpha-vantage.p.rapidapi.com'
    request["x-rapidapi-key"] = 'b629a43ff0msh128b21c6bcd2d9cp1d32a1jsn84966b99aeea'
    
    response = http.request(request)
    j = JSON.parse(response.body)

  # puts j 
  # puts j["Global Quote"]["01. symbol"]
  # puts j["Global Quote"]["05. price"]

def get_stock(symbol)
  url = URI("https://apidojo-yahoo-finance-v1.p.rapidapi.com/stock/v2/get-summary?region=US&symbol=#{symbol}")

  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE

  request = Net::HTTP::Get.new(url)
  request["x-rapidapi-host"] = 'apidojo-yahoo-finance-v1.p.rapidapi.com'
  request["x-rapidapi-key"] = 'b629a43ff0msh128b21c6bcd2d9cp1d32a1jsn84966b99aeea'

  response1 = http.request(request)

  j1 = JSON.parse(response1.body)

  return j1
end


def get_current_price(json_stock)
  get_stock()

  return json_stock["price"]["regularMarketPrice"]["raw"]

end #ends current price meth

puts get_current_price("TSLA")
puts get_current_price("AAPL")