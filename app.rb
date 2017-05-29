require 'colorize'
require 'active_record'
require 'sqlite3'
require 'logger'
require_relative 'config/environment'
require 'Date'
# require_relative 'lib/CLI'



class CLI
  attr_accessor :customer

  def start
    puts "Welcome to Yelpp!".colorize(:cyan)
    prompt_menu
    log_in_or_create_customer
    run_main_menu

  end

  def prompt_menu
    puts "--------"
    puts "*** MENU ***"
    puts "create = create a review for a restaurant".colorize(:yellow)
    puts "read = read all reviews of a restaurant".colorize(:yellow)
    puts "update = update a review".colorize(:yellow)
    puts "delete = delete a review".colorize(:yellow)
    puts ""
    puts "menu = display this menu".colorize(:yellow)
    puts "return = return to main menu".colorize(:yellow)
    puts "exit = exit the program".colorize(:yellow)
    puts "--------"
  end

  def run_main_menu
    loop do
      puts "What would you like to do next?".colorize(:light_blue)
      input = gets.chomp
      case input
      when 'exit'
        exit(0)
      when 'menu'
        prompt_menu
      when 'create'
        create_review
      when 'read'
        display_all_reviews_by_customer
      when 'update'
        update_review
      when 'delete'
        delete_review
      when 'return'
        run_main_menu
      else
        puts "Command not found. Please choose from the menu.".colorize(:red)
        prompt_menu
      end
    end
  end

  def sign_up_new_customer
    puts "Please chose a user name:".colorize(:light_blue)
    input = gets.chomp
    @customer = Customer.create(name: input)
    puts "Your account with ID #{@customer.id} and user name '#{@customer.name}' was created".colorize(:green)
  end

  def log_in_or_create_customer
    puts "Please enter your user name".colorize(:light_blue)

    loop do
      input = gets.chomp
      exit_or_menu?(input)
      @customer = Customer.find_by_name(input)
      if !@customer.nil?
        puts "Hello, #{@customer.name}!".colorize(:light_blue)
        break
      elsif input == "sign up"
        sign_up_new_customer
        break
      else
        puts "We could not find '#{input}'. Please re-type your user name or type 'sign up' to create a new account.".colorize(:light_blue)
      end
    end
  end

  def exit_or_menu?(input)
    case input
    when 'exit'
      exit(0)
    when 'menu'
      prompt_menu
    when 'return'
      run_main_menu
    end
  end

  def display_all_restaurants
    Restaurant.all.each do |restaurant|
      puts restaurant.name
    end
  end

  def display_all_reviews_by_customer
    puts "These are all your reviews:".colorize(:light_blue)
    reviews = @customer.reviews
    reviews.reload
    if reviews.nil? || reviews.empty?
      puts "You have currently no reviews saved in your history.".colorize(:red)
    else
      @customer.reviews.each_with_index do |review, index|
        puts "Review \##{index + 1}: #{review.rating} out of 10 stars for #{review.restaurant.name} on #{review.date} by #{review.customer.name}".colorize(:light_magenta)
      end
    end
  end

  def delete_review

    display_all_reviews_by_customer
    puts "Enter the review \# to delete:".colorize(:light_blue)

    loop do
      input = gets.chomp
      review = @customer.reviews[input.to_i - 1]
      # puts review.inspect
      exit_or_menu?(input)

      if review.nil?
        puts "Review \# not valid. Please try again.".colorize(:red)
      else
        review.destroy
        puts "Your review was successfully deleted.".colorize(:green)
        break
      end
    end
  end

  def create_review
    restaurant = nil

    puts "What is the name of the restaurant that you would like to rate?".colorize(:light_blue)

    loop do
      input = gets.chomp
      restaurant = Restaurant.find_by_name(input)
      exit_or_menu?(input)
      if input == "new"
        puts "What is the name of the new restaurant?".colorize(:light_blue)
        name = gets.chomp
        restaurant = Restaurant.create(name: name)
        puts "Restaurant '#{restaurant.name}' was successfully created.".colorize(:green)
        break
      elsif input == "list"
        display_all_restaurants
        puts "What is the name of the restaurant that you would like to rate?".colorize(:light_blue)
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

  def update_review
    restaurants = @customer.restaurants.uniq
    restaurant = nil
    reviews = nil
    review = nil

    puts "You have created reviews for these restaurants:".colorize(:light_blue)
    restaurants.uniq.each do |restaurant|
      restaurant_count = @customer.restaurants.where(name: restaurant.name).count.to_s
      puts "#{restaurant.name} - #{restaurant_count} review(s)".colorize(:light_magenta)
    end


    puts "Enter the restaurant name to see all your reviews".colorize(:light_blue)

    loop do
      input = gets.chomp
      restaurant = restaurants.select { |restaurant| restaurant[:name] == input }
      reviews = @customer.reviews.where(restaurant: restaurant)

      exit_or_menu?(input)

      if restaurant.nil? || restaurant.empty?
        puts "Restaurant name not found. Please type again (capital sensitive).".colorize(:red)
      else
        puts "#{restaurant[0].name} has received following rating(s) from you:".colorize(:light_blue)
        reviews.each_with_index do |review, index|
          puts "Review \##{index + 1}: #{review.rating} out of 10 stars on #{review.date}".colorize(:light_magenta)
        end
        break
      end
    end

    puts "What is the Review \# that you would like to update?".colorize(:light_blue)

    loop do
      input = gets.chomp
      review = reviews[input.to_i - 1]

      exit_or_menu?(input)

      if review.nil?
        puts "Review \# not valid. Please try again.".colorize(:red)
      else
        break
      end
    end

    puts "What is the new rating that you would like to give? (1-10)".colorize(:light_blue)

    loop do
      input = gets.chomp.to_i
      exit_or_menu?(input)

      if !(input >= 0 && input <= 10)
        puts "Please enter a rating between 1 and 10".colorize(:red)
      else
        date = (Date.today).to_s
        review.update(rating: input, date: date)
        puts "Your review was successfully updated:".colorize(:green)
        puts "Review \##{reviews.index(review) + 1}: #{review.rating} out of 10 stars on #{review.date}".colorize(:light_magenta)
        break
      end
    end
  end

end
#
# anna = Customer.find_by_name("Anna")
# amarillo = Restaurant.find_by_name("Amarillo")

CLI.new.start
