class Restaurant < ActiveRecord::Base
  has_many :reviews
  has_many :customers, through: :reviews

  validates_presence_of :name
  validates :name, uniqueness: true

  def average_rating
    self.reviews.average(:rating).to_f
  end

  def print_reviews
    puts "***** Amarillo Reviews ***** "
    self.reviews.each do |review|
      puts "#{review.customer.name}".colorize(:light_blue) + " gave a rating of"
      puts "#{review.rating} out of 10 stars".colorize(:yellow) + " (#{review.date})"
    end
    puts ""
    puts "#{self.name}\'s average rating is: #{average_rating}".colorize(:yellow)
  end


  

end
