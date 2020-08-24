require 'net/http'
require 'open-uri'
require 'json'
require_relative './Investor.rb'

class Stock

    attr_accessor :symbol, :shares
    attr_reader :json_stock, :address, :price, :company

    @@all = []

    def initialize(stock)
        @symbol = stock
        @shares = 0
        get_stock
        get_basic_info
        @@all << self
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
        
        @price  = @json_stock["price"]["regularMarketPrice"]["raw"]
        @price
    end                     #ends current price meth
    def get_price
        
        @price  = @json_stock["price"]["regularMarketPrice"]["raw"]
        @price
    end                     #ends get price meth


    def get_name
        
        @company = @json_stock["quoteType"]["longName"]
        @company
    end                     #ends get price meth


    def get_address
        address = ""
        address = address + @json_stock["summaryProfile"]["address1"]
        address = address + ", " + @json_stock["summaryProfile"]["city"]
        address = address + ", " +  @json_stock["summaryProfile"]["state"]
        address = address + "  " +  @json_stock["summaryProfile"]["zip"]
        @address = address
        @address
    end

    def basic_info
        puts "Symbol: #{@symbol}"
        puts "Company: #{@company}"
        puts "Address: #{@address}"
        puts "Current Price: #{@price}"
    end

    def get_basic_info
        get_name
        get_address
        get_price
    end



end
