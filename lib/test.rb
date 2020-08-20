require_relative './Stock.rb'
require_relative './Investor.rb'

# new_stock = Stock.new("FB")
# new_stock.basic_info



john = Investor.new("John")
john.buy_stock("AAPL",2)
puts "cash = #{john.cash}"


