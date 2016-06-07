require "./db/setup"
require "./lib/all"

all_items = Item.all
#1. How many items are there?----------------
total_items = all_items.count
puts
puts "There are #{total_items} items."

#2. What is the most expensive item?---------
#Item.maximum("price")
most_exp_item = Item.where(price: Item.maximum("price")).first
# all_items.each do |item|
#   if item.price.to_f > most_exp_item.price.to_f
#     most_exp_item = item
#   end
# end

puts
puts "There most expensive item is #{most_exp_item.description}."

#3. Who lives at 7153 Predovic Falls?---------
all_addresses = Address.all
p_falls = all_addresses.where(street: "7153 Predovic Falls").first

puts
puts "#{p_falls.user.first_name} #{p_falls.user.last_name} lives at 7153 Predovic Falls."

#4. How many Mediocre Copper Bottles did we sell?--
mcb_item = all_items.find_by(description: "Mediocre Copper Bottle")
sold = mcb_item.purchases.map {|purch| purch.quantity}.reduce(:+)

puts
puts "We sold #{sold} Mediocre Copper Bottles"

#5. What is our total revenue (item cost * quantity sold for all purchases)?
all_purchases = Purchase.all
total_revenue = all_purchases.map {|purch| (purch.item.price.to_f)*(purch.quantity)}.reduce(:+)

puts
puts "Our total revenue is $#{total_revenue.round(2)}!"
