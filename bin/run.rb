require_relative '../config/environment'
require 'colorize'

anna = Customer.new("Anna")
bob = Customer.new("Bob")
monica = Customer.new("Monica")

amarillo = Restaurant.new("Amarillo")
bellagio = Restaurant.new("Bellagio")
tosca = Restaurant.new("Tosca")

anna.create_review(amarillo, 8, "8/15/17")
anna.create_review(amarillo, 6, "9/25/17")
anna.create_review(bellagio, 5, "10/8/17")
bob.create_review(amarillo, 7, "12/6/17")
bob.create_review(bellagio, 10, "11/28/17")
bob.create_review(tosca, 3, "4/5/17")
bob.create_review(tosca, 4, "7/17/17")
monica.create_review(bellagio, 9, "2/5/16")
monica.create_review(tosca, 8, "5/5/13")

# puts "Here are all the customers:"
# Customer.all.each { |customer| puts customer.inspect}
# puts ""
#
# puts "Here are all the restaurants:"
# Restaurant.all.each { |customer| puts customer.inspect}
# puts ""
#
# puts "Here are all the reviews:"
# Review.all.each { |customer| puts customer.inspect}
# puts ""

Restaurant.all.each do |restaurant|
  puts ""
  puts "***** #{restaurant.name.upcase} *****".colorize(:yellow)
  puts "All reviews for #{restaurant.name}:".colorize(:blue)
  restaurant.all_reviews.each do |review|
    puts "#{review.customer.name} gave a rating of #{review.rating} on #{review.date}"
  end
  puts ""

  puts "#{restaurant.name} has #{restaurant.all_customers.length} customers:".colorize(:blue)
  restaurant.all_customers.each { |customer| puts customer.name }
  puts ""

  puts "Reviews sorted by customers".colorize(:blue)
  restaurant.find_reviews_by_customer.each do |customer, review|
    puts "#{customer.name} gave these reviews:"
    review.each { |review| puts "#{review.rating} (#{review.date})" }
  end
end
