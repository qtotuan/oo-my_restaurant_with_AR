require_relative 'CLI_create'
require_relative 'CLI_read'
require_relative 'CLI_update'
require_relative 'CLI_delete'

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
    exit_or_menu?(input)

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

end
