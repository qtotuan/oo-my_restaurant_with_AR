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
    exit_or_menu?(input)

    restaurant = restaurants.select { |restaurant| restaurant[:name] == input }
    reviews = @customer.reviews.where(restaurant: restaurant)

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
    exit_or_menu?(input)

    review = reviews[input.to_i - 1]

    if review.nil? || input.to_i == 0
      puts "Review \# not valid. Please try again.".colorize(:red)
    else
      break
    end
  end

  puts "What is the new rating that you would like to give? (1-10)".colorize(:light_blue)

  loop do
    input = gets.chomp
    exit_or_menu?(input)

    if !(input.to_i > 0 && input.to_i <= 10)
      puts "Please enter a rating between 1 and 10".colorize(:red)
    else
      date = (Date.today).to_s
      review.update(rating: input.to_i, date: date)
      puts "Your review was successfully updated:".colorize(:green)
      puts "Review \##{reviews.index(review) + 1}: #{review.rating} out of 10 stars on #{review.date}".colorize(:light_magenta)
      break
    end
  end
end
