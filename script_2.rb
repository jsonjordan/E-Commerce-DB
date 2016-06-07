require "./db/setup"
require "./lib/all"

# Prompts the user for their name

puts "What is your first name?"
first_name = gets.chomp
puts "What is your last name?"
last_name = gets.chomp

user = User.where(first_name: first_name, last_name: last_name).first_or_create!
all_items = Item.all
loop do
  # Displays a list of available items

  puts
  puts "Avaliable Items:"
  all_items.each do |item|
    puts "#{item.id}) #{item.description}"
  end

  # Asks the user to choose an item

  puts "Please choose an item number to purchase."
  print " >"
  item_number = gets.chomp
  item = all_items.find_by(id: item_number)

  # Asks the user for a quantity

  puts "How many #{item.description}s would you like to purchase?"
  print " >"
  quantity = gets.chomp.to_i

  # Creates a new order for that user / item / quantity

  user_purchase = Purchase.create(user_id: user.id, item_id: item.id, quantity: quantity)
  puts
  puts "---Aardwolf Inc.---".center(40)
  puts "Purchase invoice ##{user_purchase.id}".center(40)
  puts "#{user.first_name} #{user.last_name}".center(40)
  puts "#{item.description} x#{user_purchase.quantity}".center(40)
  puts "at $#{user_purchase.item.price.to_f.round(2)} each".center(40)
  puts "total: $#{((user_purchase.item.price.to_f)*(user_purchase.quantity)).round(2)}".center(40)
  puts "Purchase made at #{user_purchase.created_at}".center(40)
  puts "-------------------".center(40)
  puts
  puts "Would you like to make another purchase (y/n)?"
  input = gets.chomp
  unless input == "y"
    break
  end
end
