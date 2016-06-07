require "./db/setup"
require "./lib/all"

def get_user
  puts "What is your first name?"
  first_name = gets.chomp
  puts "What is your last name?"
  last_name = gets.chomp

  User.where(first_name: first_name, last_name: last_name).first_or_create!
end

def display_item_list item_list
  puts
  puts "Avaliable Items:"
  item_list.each do |item|
    puts "#{item.id}) #{item.description}"
  end
end

def get_item item_list
  puts "Please choose an item number to purchase."
  print " >"
  item_number = gets.chomp
  item = item_list.find_by(id: item_number)
end

def get_quantity item
  puts "How many #{item.description}s would you like to purchase?"
  print " >"
  quantity = gets.chomp.to_i
end

def create_and_display_invoice user, item, quantity
  user_purchase = Purchase.create(user_id: user.id, item_id: item.id, quantity: quantity)
  puts
  puts "---Aardwolf Inc.---".center(40)
  puts "Purchase invoice ##{user_purchase.id}".center(40)
  puts "#{user.first_name} #{user.last_name}".center(40)
  puts "#{item.description} x#{user_purchase.quantity}".center(40)
  puts "at $#{user_purchase.item.price.to_f.round(2)} each".center(40)
  puts "total: $#{((user_purchase.item.price.to_f)*(user_purchase.quantity)).round(2)}".center(40)
  puts "Purchase made at".center(40)
  puts "#{user_purchase.created_at}:".center(40)
  puts "-------------------".center(40)
end

def additional_purchase?
  puts
  puts "Would you like to make another purchase (y/n)?"
  input = gets.chomp
end


# Prompts the user for their name

user = get_user
item_list = Item.all
loop do
  # Displays a list of available items

  display_item_list item_list

  # Asks the user to choose an item

  item = get_item item_list

  # Asks the user for a quantity

  quantity = get_quantity item

  # Creates a new order for that user / item / quantity

  create_and_display_invoice user, item, quantity

  input = additional_purchase?

  unless input == "y"
    break
  end
end
