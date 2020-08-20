require 'net/http'
require 'open-uri'
require 'json'

class Stock

    attr_accessor :symbol 
    attr_reader :json_stock

    def initialize(stock)
        @symbol = stock
        get_stock

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
        
        @json_stock["price"]["regularMarketPrice"]["fmt"]
        
    end                     #ends current price meth
    def get_price
        
        @json_stock["price"]["regularMarketPrice"]["fmt"]
        
    end                     #ends get price meth

    def get_name
        
        @json_stock["quoteType"]["longName"]
        
    end                     #ends get price meth

    def get_address
        address = ""
        address = address + @json_stock["summaryProfile"]["address1"]
        address = address + ", " + @json_stock["summaryProfile"]["city"]
        address = address + ", " +  @json_stock["summaryProfile"]["state"]
        address = address + "  " +  @json_stock["summaryProfile"]["zip"]
        address
    end

    def basic_info
        puts "Symbol: #{self.symbol}"
        puts "Company: #{self.get_name}"
        puts "Address: #{self.get_address}"
        puts "Current Price: #{self.get_price}"
    end



end

new_stock = Stock.new("FB")
new_stock.basic_info

