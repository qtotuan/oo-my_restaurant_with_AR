def create_review
  restaurant = nil


  loop do
    puts "What is the name of the restaurant that you would like to rate?".colorize(:light_blue)
    input = gets.chomp
    exit_or_menu?(input)

    restaurant = Restaurant.find_by_name(input)

    if input == "new"
      create_new_restaurant
      break
    elsif input == "list"
      display_all_restaurants
    elsif restaurant.nil?
      puts "Restaurant name not found.".colorize(:red)
      puts "Please check your spelling (case sensitive).".colorize(:light_blue)
      puts "Type 'new' to create a new restaurant.".colorize(:light_blue)
      puts "Type 'list' to see a list of all restaurants in the database.".colorize(:light_blue)
    else
      puts "#{restaurant.name} was found in the database".colorize(:green)
      break
    end
  end

  puts "What rating would you like to give for #{restaurant.name}? (1-10)".colorize(:light_blue)

  loop do
    input = gets.chomp
    exit_or_menu?(input)

    if !(input.to_i >= 1 && input.to_i <= 10)
      puts "Please enter a rating between 1 and 10".colorize(:red)
    else
      date = (Date.today).to_s
      review = Review.create(rating: input.to_i, date: date, customer: @customer, restaurant: restaurant)
      puts "Your review was successfully created:".colorize(:green)
      puts "#{review.rating} out of 10 stars for #{restaurant.name} on #{review.date} by #{review.customer.name}".colorize(:light_magenta)
      break
    end
  end
end


def create_new_restaurant
  puts "What is the name of the new restaurant?".colorize(:light_blue)

  input = gets.chomp
  exit_or_menu?(input)

  name = gets.chomp
  restaurant = Restaurant.create(name: name)

  puts "Restaurant '#{restaurant.name}' was successfully created.".colorize(:green)
end
