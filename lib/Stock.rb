require 'net/http'
require 'open-uri'
require 'json'



class Stock


    attr_accessor :symbol 
    attr_reader :json_stock

    def initialize(stock)
        @symbol = stock
    end



    def get_stock
        url = URI("https://apidojo-yahoo-finance-v1.p.rapidapi.com/stock/v2/get-summary?region=US&symbol=#{@symbol}")
        
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        
        request = Net::HTTP::Get.new(url)
        request["x-rapidapi-host"] = 'apidojo-yahoo-finance-v1.p.rapidapi.com'
        request["x-rapidapi-key"] = 'b629a43ff0msh128b21c6bcd2d9cp1d32a1jsn84966b99aeea'
        
        response1 = http.request(request)
        
        @json_stock = JSON.parse(response1.body)
        
    end
        
        
    def get_current_price
        get_stock()
        
        return @json_stock["price"]["regularMarketPrice"]["raw"]
        
    end #ends current price meth


end

new = Stock.new("AAPL")
puts new.get_current_price