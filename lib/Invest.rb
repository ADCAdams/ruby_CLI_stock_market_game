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
        @player = Investor.new(@name)
        puts "#{@name}, you've started with $#{@player.cash}. Now, using real-time stock market data you can choose to buy and sell any stock you like!"
    end


    def play
        sleep(2)
        puts "Menu! #{@name}, you can choose to 'buy' shares a stock , 'sell' a stock you own, check how much 'cash' you have, 'learn' details about a stock, or 'quit'."
        case gets.strip 
        when "buy"
            puts "buyinnnn"
        else
            puts "Please choose by typiing either 'buy', 'sell', 'cash', 'learn',  or 'quit'."
        end

    end

    def buying
        
        puts "Okay! lets buy some stocks!"
        sleep(1)
        puts "Using the ticker symbol, which stock would you like to buy? (e.g. AAPL or TSLA)"
        user_input_stock = gets.strip

    end                             #ends buying

end

