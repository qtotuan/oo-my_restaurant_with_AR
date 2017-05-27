Customer.create(name: "Anna")
Customer.create(name: "Bob")
Customer.create(name: "Monica")
Customer.create(name: "Catherine")
Customer.create(name: "Thomas")
Customer.create(name: "Benedict")

Restaurant.create(name: "Amarillo")
Restaurant.create(name: "Bellagio")
Restaurant.create(name: "Tosca")

5.times do
  customer = Customer.all.shuffle.first
  restaurant = Restaurant.all.shuffle.first
  rating = rand(1..10)
  date = (Date.today - rand(1..365)).to_s
  Review.create(customer: customer, restaurant: restaurant, rating: rating, date: date)
end
