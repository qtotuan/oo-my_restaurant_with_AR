class Customer < ActiveRecord::Base
  has_many :reviews
  has_many :restaurants, through: :reviews

  validates_presence_of :name
  validates :name, uniqueness: true

  def create_review(restaurant, rating)
    date = (Date.today - rand(1..365)).to_s
    Review.create(customer: self, restaurant: restaurant, rating: rating, date: date)
  end

end
