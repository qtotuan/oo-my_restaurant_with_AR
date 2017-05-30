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
