class Customer
  attr_accessor :name, :reviews

  @@all = []

  def initialize(name)
    @name = name
    @reviews = []
    @@all << self
  end

  def self.all
    @@all
  end

  def all_restaurants
    reviews.each do |review|
      review.restaurant
    end
  end

  def create_review(restaurant, rating, date)
    review = Review.new(restaurant, rating, date)
    review.customer = self
    reviews << review
  end

end
