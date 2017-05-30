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
