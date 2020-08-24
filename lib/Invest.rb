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
        puts "#{@name}, you have $#{(@player.cash).round(2)} and #{@player.stocks.length} different stocks."
        puts "* * * * * * * * * * * * * * * * "
        puts "You can choose to:"
        puts "'buy'     - buy shares of a stock" 
        puts "'sell'    - sell a stock you own" 
        puts "'quote    - get the current price of a stock"
        puts "'learn'   - learn details about any stock" 
        puts "'shares'  - see how many shares you have of owned stocks"
        puts "'value'   - calculate total portfolio value"
        puts "or 'quit'"
        puts "* * * * * * * * * * * * * * * * "
        case gets.strip 
        when "buy"
            buying
        when 'sell'
            selling
        when "quit"
            exit
        when "quote"
            quoting
        when "shares"
            shares
        when "learn"
            learning
        when 'value'
            valuing
        else
            puts "Please choose by typing either 'buy', 'sell', 'cash', 'learn',  or 'quit'."
            play
        end

    end
    def quoting
        stock_symbol = get_user_stock
        new_stock = Stock.new(stock_symbol)

        puts "#{stock_symbol} is currently valued at $#{new_stock.get_current_price} per share."
        sleep(2)
        play
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
        if @player.last_price == nil
            puts "You don't have enough cash!"
            sleep(1)
            puts "With your remaining cash, you *can*, however, buy #{@player.possible_purchase_shares} shares of #{@player.last_stock_bought_sold.symbol}."
            sleep(2)
            play
        else
            puts "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
            puts "Purchased #{@player.last_quantity} shares of #{@player.last_stock_bought_sold.symbol},"
            puts "         at #{@player.last_price} per share,"
            puts "              for a total purchase of #{(@player.last_quantity * @player.last_price).round(2)}."
            puts "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
            sleep(4)
            play
        end

    end                             #ends buying

    def selling
        
        puts "Okay! lets sell some stocks!"
        sleep(1)
        puts "Here are your stocks:"
        sleep(1)
        @player.stocks.each do |stock|
            puts "#{stock.symbol} - #{stock.company} - Shares: #{stock.shares}"
        end
        sleep(2)
        puts "Using the ticker symbol, which of your stock would you like to sell? (e.g. AAPL or TSLA)"

        stock_symbol = get_user_stock

        puts "And how many shares of #{stock_symbol} would you like to sell?"
        user_input_shares = gets.strip
        user_input_shares = user_input_shares.to_i

        @player.sell_stock(stock_symbol,user_input_shares)
        puts "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
        puts "Sold #{@player.last_quantity} shares of #{@player.last_stock_bought_sold.symbol},"
        puts "         at #{@player.last_price} per share,"
        puts "              for a total purchase of #{(@player.last_quantity.to_f * @player.last_price.to_f).round(2)}."
        puts "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
        sleep(4)
        play
    end                             #ends buying

    def get_user_stock
        user_input_stock = gets.strip
        user_input_stock.upcase 
    end 
    
    def shares

        puts "Here are your shares:"
        sleep(2)
        @player.stocks.each do |stock|
            puts "#{stock.symbol} - #{stock.company} - Shares: #{stock.shares}"
        end
        sleep(2)
        play
    end

    def learning
        puts "Which stock would you like to learn about?"
        stock_symbol = get_user_stock
        stock_symbol = Stock.new(stock_symbol)
        puts "*********************"
        puts "You can see:"
        puts "  * 'name'    Company Name"
        puts "  * 'address' Company Address"
        puts "*****enter command******"
        case gets.strip 
        when "name"
            puts stock_symbol.company
        when 'address'
            puts stock_symbol.address
        else
            puts "Please enter either 'name' or 'address'"
            learning
        end
        sleep(2)
        play

    end         #ends learning

    def valuing
        puts "The total value of your cash and stock portfolio" 
        puts "      is #{@player.portfolio_value}"
        sleep (2)
        play
    end




end     #ends class

