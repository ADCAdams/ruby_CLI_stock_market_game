require 'net/http'
require 'open-uri'
require 'json'
require_relative './Stock.rb'


class Investor

    attr_accessor :name, :cash, :stocks


    def initialize(name, cash = 10000)
        @name = name 
        @cash = cash 
        @stocks = []
    end

    def new_stock(stock_symbol)
        stock_bought = Stock.new(stock_symbol)
    end

    def buy_stock(stock_symbol, shares)
        stock_symbol = stock_symbol.upcase
        stock_bought = Stock.new(stock_symbol)
        puts "price of stock is #{stock_bought.price}"
        money_spent = (stock_bought.price.to_f * shares.to_f)
        puts "money spent #{money_spent}"
        if @cash >= money_spent                             #checks if viable transaction
            @cash -= money_spent
            stock_bought.shares += shares
            @stocks << stock_bought
        else
            possible_shares = (@cash.to_f / stock_bought.price.to_f).floor
            puts "Not enough money! With your remaining cash, you *can* buy #{possible_shares} shares of #{stock_bought.symbol}."
            puts "Enter number (#) of shares of #{stock_bought.symbol} to purchase or enter 'n'/'N'/'No' to cancel transaction."

        end

    end                                         #ends buy_stock

    def sell_stock(stock_symbol, shares)
        stock_symbol = stock_symbol.upcase
        sold_stock = nil                    #stock to be sold
        cash_returned = 0

        @stocks.each_with_index do |stocky, index|                        #checking in this investor's stocks
            if stocky.symbol.upcase == stock_symbol.upcase      #checking for match of stock
                puts "FOUND"
                if stocky.shares >= shares  #checks if less or equal to total shares being sold
                    cash_returned = (stocky.get_current_price.to_f * shares.to_f).round(2)       #gets amount of cash coming back
                    stocky.shares -= shares                     #removes shares sold
                    @cash += cash_returned                      #applies cash coming back
                    @stocks.delete_at(index) if stocky.shares == 0              #deletes stock from @stocks if there are no shares left

                else 
                    puts "You are trying to sell more shares than you own. You own #{stocky.shares}."
                end

            else
                puts "Could not find your stock!"
            end
        end                         #ends each
    end                                         #ends SELL_stock


    

end                                             #ends Class

# john = Investor.new("John")
# puts "new investor #{john.name.upcase}"
# john.buy_stock("AAPL",2)
# puts john.cash
# puts john.stocks.first.price
