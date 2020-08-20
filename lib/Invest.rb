require_relative './Stock.rb'
require_relative './Investor.rb'

class CLI_Stock_Game

    attr_accessor :name, :player 

    def initialize
        intro
    end


    def intro

        # time = Time.new 
        # puts time.day
        # puts time.

        puts "Welcome shrewd investor! What is your name?"
        user_input_name = gets.strip
        @name = user_input_name
        puts "Hi, #{@name}!"
        sleep(2)
        puts "In this game we'll be using real-time stock market data."
        puts "You can choose to buy and sell any stock you like!"
        
        @player = Investor.new(@name)
        sleep(4)
        
    end


    def play
        puts "------------------------------------------------------------------------------------"
        puts "#{@name}, you have $#{@player.cash} and #{@player.stocks.length} different stocks."
        puts "* * * * * * * * * * * * * * * * "
        puts "You can choose to:"
        puts "'buy'     - buy shares of a stock" 
        puts "'sell'    - sell a stock you own" 
        puts "'cash'    - check how much cash you have available"
        puts "'learn'   - learn details about any stock" 
        puts "'shares'  - see how many shares you have of owned stocks"
        puts "or 'quit'"
        puts "* * * * * * * * * * * * * * * * "
        case gets.strip 
        when "buy"
            buying
        when 'sell'
            selling
        when "quit"
            exit
        when "shares"
            shares
        when "learn"
            learning
        else
            puts "Please choose by typiing either 'buy', 'sell', 'cash', 'learn',  or 'quit'."
            play
        end

    end

    def buying
        
        puts "Okay! lets buy some stocks!"
        sleep(1)
        puts "Using the ticker symbol, which stock would you like to buy? (e.g. AAPL or TSLA)"
        stock_symbol = get_user_stock
        puts "And how many shares of #{stock_symbol} would you like to buy?"
        user_input_shares = gets.strip
        user_input_shares = user_input_shares.to_i

        @player.buy_stock(stock_symbol,user_input_shares)
        puts "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
        puts "Purchased #{@player.last_quantity} shares of #{@player.last_stock_bought_sold},"
        puts "         at #{@player.last_price} per share,"
        puts "              for a total purchase of #{(@player.last_quantity.to_f * @player.last_price.to_f).round(2)}."
        puts "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
        sleep(4)
        play
    end                             #ends buying

    def selling
        
        puts "Okay! lets sell some stocks!"
        sleep(1)
        puts "Here are your stocks:"
        sleep(3)
        @player.stocks.each do |stock|
            puts "#{stock.symbol} - #{stock.company}" 
        end
        puts "Using the ticker symbol, which of your stock would you like to sell? (e.g. AAPL or TSLA)"

        stock_symbol = get_user_stock

        puts "And how many shares of #{stock_symbol} would you like to sell?"
        user_input_shares = gets.strip
        user_input_shares = user_input_shares.to_i

        @player.sell_stock(stock_symbol,user_input_shares)
        play
    end                             #ends buying

    def get_user_stock
        user_input_stock = gets.strip
        user_input_stock.upcase 
    end 
    
    def shares
        puts "Enter stock symbol to fetch your shares"
        stock_symbol = get_user_stock
        index = @player.check_if_owned(stock_symbol)
        if index != false
            puts "You have #{@player.stocks[index].shares} shares of #{stock_symbol}."
            sleep(3)
        else
            puts "You do not own this stock."
            sleep(2)
        end
        play
    end

    def learning
        puts "Which stock would you like to learn about?"
        stock_symbol = get_user_stock
        puts "*********************"
        puts "You can see:"
        puts "  * 'name'    Company Name"
        puts "  * 'address' Company Address"
        puts "*****enter command******"
    end

end

