require 'net/http'
require 'open-uri'
require 'json'
require_relative './Stock.rb'


class Investor

    attr_accessor :name, :cash, :stocks


    def initialize(name, cash = 10000)
        puts "new investor created #{name}"
        @name = name 
        @cash = cash 
        @stocks = []
    end

    def new_stock(stock_symbol)
        stock_bought = Stock.new(stock_symbol)
    end

    def buy_stock(stock_symbol, shares)
        stock_bought = Stock.new(stock_symbol)
        puts stock_bought
        puts stock_bought.price
        money_spent = (stock_bought.price.to_f * shares.to_f)
        puts "money spent #{money_spent}"
        if @cash >= money_spent
            puts "YES"
            @cash -= money_spent
            stock_bought.shares += shares
            @stocks << stock_bought
        else
            puts "Not enough money!"
        end

    end                                         #ends buy_stock

    # def sell_stock(stock_symbol, shares)

    #     stock_bought = Stock.new(stock_symbol)
    #     puts stock_bought
    #     puts stock_bought.price
    #     money_spent = (stock_bought.price.to_f * shares.to_f)
    #     puts "money spent #{money_spent}"
    #     if @cash >= money_spent
    #         puts "YES"
    #         @cash -= money_spent
    #         stock_bought.shares += shares
    #         @stocks << stock_bought
    #     else
    #         puts "Not enough money!"
    #     end

    # end                                         #ends SELL_stock


    def invest
        puts "Welcome shrewd investor! What is your name?"
        user_input_name = gets.strip
    end


end                                             #ends Class

# john = Investor.new("John")
# puts "new investor #{john.name.upcase}"
# john.buy_stock("AAPL",2)
# puts john.cash
# puts john.stocks.first.price
