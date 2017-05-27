class Review
  attr_accessor :restaurant, :customer, :rating, :date

  @@all = []

  def initialize (restaurant, rating, date)
    @restaurant = restaurant
    @rating = rating
    @date = date
    @customer
    @@all << self
    restaurant.reviews << self
  end

  def self.all
    @@all
  end

end
