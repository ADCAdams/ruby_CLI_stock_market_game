require 'net/http'
require 'open-uri'
require 'json'
require_relative './Stock.rb'



class Investor

    attr_accessor :name, :stocks
    attr_reader :last_price, :last_quantity, :last_stock_bought_sold, :cash, :possible_purchase_shares


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
        owned = false

        if check_if_owned(stock_symbol) != false 
            owned = true
            stock_bought = @stocks[check_if_owned(stock_symbol)]
        else
            stock_bought = Stock.new(stock_symbol)
        end

        @last_price = (stock_bought.price)          #used to easily say what we bought and for what
        @last_quantity = shares.to_f

        money_spent = (@last_price * @last_quantity)
        @last_stock_bought_sold = stock_bought 

        if @cash >= money_spent                             #checks if viable transaction
            @cash = (@cash - money_spent)
            stock_bought.shares += shares

            @stocks << stock_bought if owned == false
        else
            @possible_purchase_shares = (@cash.to_f / stock_bought.price).floor.to_i
            @last_quantity = nil
            @last_price = nil
        end

    end                                         #ends buy_stock



    def sell_stock(stock_symbol, shares)
        stock_symbol = stock_symbol.upcase
        sold_stock = nil                    #stock to be sold
        cash_returned = 0

        @stocks.each_with_index do |stocky, index|                        #checking in this investor's stocks
            if stocky.symbol.upcase == stock_symbol.upcase      #checking for match of stock
                if stocky.shares >= shares  #checks if less or equal to total shares being sold
                    @last_quantity = shares.to_f
                    @last_price = stocky.get_current_price
                    @last_stock_bought_sold = stocky
                    cash_returned = (@last_price * @last_quantity)       #gets amount of cash coming back
                    stocky.shares -= shares                     #removes shares sold
                    @cash = (@cash + cash_returned)                  #applies cash coming back
                    @stocks.delete_at(index) if stocky.shares == 0              #deletes stock from @stocks if there are no shares left

                else 
                    puts "You are trying to sell more shares than you own. You own #{stocky.shares}."
                end
            end
        end                         #ends each
    end                                         #ends SELL_stock

    def check_if_owned(stock_symbol)
        @stocks.each_with_index do |stocky, index|                        #checking in this investor's stocks
            return index if stocky.symbol.upcase == stock_symbol.upcase      #checking for match of stock
        end
        return false 
    end


    def portfolio_value
        total_stock_val = @cash
        @stocks.each do |stocky|                        
            total_stock_val += stock_value(stocky)
        end
        total_stock_val
    end

    def stock_value(stock_obj)
        (stock_obj.shares.to_f * stock_obj.get_current_price).round(2)
    end


end                                             #ends Class
