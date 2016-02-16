# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Tour.all.destroy_all

10.times do
  name = ["first", "second", "third", "fourth"].sample
  live = [true, false].sample
  guide_level = (0..5).to_a.sample
  language = ["French", "Chinese", "Italian"].sample
  address = "11 square"
  price = (10..50).to_a.sample
  user_id = 1
  description = "okngaeorg"

  Tour.create!(description: description, name: name, live: live, guide_level: guide_level, language: language, address: address, price: price, user_id: user_id)

end
