
class Stock

    attr_accessor :symbol, :shares
    attr_reader :json_stock, :address, :price, :company



    def initialize(stock)
        @symbol = stock
        @shares = 0
        get_stock
        get_basic_info
 
    end



    def get_stock

        new_stock = Api.new(@symbol)
        @json_stock = new_stock.fetch_stock
    end
        
        
    def get_current_price
        get_stock()

        @price  = @json_stock["price"]["regularMarketPrice"]["raw"]
        @price
    end                     #ends current price method

    def get_price
        
        @price  = @json_stock["price"]["regularMarketPrice"]["raw"]
        @price
    end                     #ends get price method


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
