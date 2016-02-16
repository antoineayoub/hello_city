# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#
require 'faker'

Booking.destroy_all
User.destroy_all

# CREATE USER
user_tbl_id = []
tour_tbl_id = []

10.times do
  password = Faker::Internet.password(8)
  first_name = Faker::Name.first_name
  user = User.new(
          first_name: first_name,
          last_name: Faker::Name.last_name,
          email: Faker::Internet.email(first_name),
          password: password
          )
  user.save
  user_tbl_id << user.id

  puts "Email: #{user.email} Password: #{password}"
end

# CREATE TOUR
10.times do
  tour = Tour.new(
          name: Faker::Hipster.sentence(3),
          description: Faker::Hipster.sentences,
          live: 1,
          guide_level: Faker::Number.between(1, 5),
          price: Faker::Number.between(40, 80),
          user_id: Faker::Number.between(user_tbl_id.first, user_tbl_id.last),
          address: Faker::Address.street_address,
          language: Faker::Address.country
          )
  tour.save
  tour_tbl_id << tour.id
end

# CREATE BOOKINGS

20.times do
  tour_id = Faker::Number.between(tour_tbl_id.first, tour_tbl_id.last)
  booking = Booking.new(
    start_at: Faker::Time.between(DateTime.now, DateTime.now + 100),
    status: 'pending',
    user_id: Faker::Number.between(user_tbl_id.first, user_tbl_id.last),
    tour_id: tour_id,
    price: Tour.find(tour_id).price
    )
  booking.save
end

