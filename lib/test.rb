require_relative './Stock.rb'
require_relative './Investor.rb'

# new_stock = Stock.new("FB")
# new_stock.basic_info



john = Investor.new("John")
puts "first cash = #{john.cash}"
john.buy_stock("AAPL",200)
puts "after cash = #{john.cash}"


