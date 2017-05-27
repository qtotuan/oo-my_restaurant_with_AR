class Restaurant
  attr_accessor :name, :reviews

  @@all = []

  def initialize(name)
    @name = name
    @@all << self
    @reviews = []
  end

  def self.all
    @@all
  end

  def all_reviews
    # A restaurant should not be qble to query Review.all (private information)
    # Instead, it is the Review responsibility (Yelp) to assign the review to each restaurant
    reviews
  end

  def all_customers
    Review.all.map do |review|
      review.customer
    end.uniq
  end

  def find_reviews_by_customer
    hash = {}
    all_reviews.each do |review|
      if hash[review.customer].nil?
        hash[review.customer] = [review]
      else
        hash[review.customer] << review
      end
    end
    hash
  end

end
