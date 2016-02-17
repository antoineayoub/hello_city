# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#
require 'faker'
require 'cloudinary'

Booking.destroy_all
User.destroy_all

# CREATE USER
user_tbl_id = []
tour_tbl_id = []
tbl_pic = []
cpt = 0

tbl_pic = %w(http://elfnordics.com/mediabank/var/resizes/e.l.f.-Scandinavia-Staff/PROFILE-Celine-01-square.jpg
http://whysquare.co.nz/wp-content/uploads/2013/07/profile_square3-270x270.jpg
http://rorganize.it/uploads/person/picture/89/person_profile_avatar_face_shrunk_square_200x200.jpg
http://static1.squarespace.com/static/53af1c83e4b0b3e1fc2000bd/53b0a50be4b0d621f6aa6072/5636475be4b0507883434959/1446397788072/Randy+Krum+Profile+Photo+square.jpg
)

4.times do
  password = Faker::Internet.password(8)
  first_name = Faker::Name.first_name
  user = User.new(
          first_name: first_name,
          last_name: Faker::Name.last_name,
          email: Faker::Internet.email(first_name),
          password: password
          )

  user.picture_url = tbl_pic[cpt]

  user.save
  user_tbl_id << user.id
  cpt = cpt + 1
  puts "Id: #{user.id} Email: #{user.email} Password: #{password}"
end

# CREATE TOUR
tour = Tour.new(
          name: "Paris Eternel - 2H",
          description: "Pour une première approche de Paris ou une redécouverte de la Capitale Authentique.",
          live: 1,
          guide_level: Faker::Number.between(1, 5),
          price: Faker::Number.between(40, 80),
          user_id: Faker::Number.between(user_tbl_id.first, user_tbl_id.last),
          address: "Champ de Mars, 5 Avenue Anatole France, 75007 Paris",
          language: "French"
          )
tour.photo_urls = %w[http://www.parisclassictour.com/wcms/img/-size-17206-900-600.jpg,
  http://www.parisclassictour.com/wcms/img/-size-17207-900-600.jpg,
  http://www.parisclassictour.com/wcms/img/-size-17208-900-600.jpg,
  http://www.parisclassictour.com/wcms/img/-size-17209-900-600.jpg]
tour.save
tour_tbl_id << tour.id
tour = Tour.new(
          name: "Paris Incontournable - 1H",
          description: "Pour une visite des monuments les plus incontournables de Paris.",
          live: 1,
          guide_level: Faker::Number.between(1, 5),
          price: Faker::Number.between(40, 80),
          user_id: Faker::Number.between(user_tbl_id.first, user_tbl_id.last),
          address: "35 Rue du Chevalier de la Barre, 75018 Paris",
          language: "French",
          )
tour.photo_urls = %w[http://www.parisclassictour.com/wcms/img/-size-17206-900-600.jpg,
  http://www.parisclassictour.com/wcms/img/-size-17210-900-600.jpg,
  http://www.parisclassictour.com/wcms/img/-size-17211-900-600.jpg,
  http://www.parisclassictour.com/wcms/img/-size-17212-900-600.jpg]

tour.save
tour_tbl_id << tour.id
tour = Tour.new(
          name: "Paris By Night - 1H",
          description: "Découvrez les mystères de Paris by night.",
          live: 1,
          guide_level: Faker::Number.between(1, 5),
          price: Faker::Number.between(40, 80),
          user_id: Faker::Number.between(user_tbl_id.first, user_tbl_id.last),
          address: "6 Parvis Notre-Dame - Pl. Jean-Paul II, 75004 Paris",
          language: "French"
          )
tour.photo_urls = %w[http://www.parisclassictour.com/wcms/img/-size-17206-900-600.jpg,
  http://www.parisclassictour.com/wcms/img/-size-17213-900-600.jpg,
  http://www.parisclassictour.com/wcms/img/-size-17214-900-600.jpg,
  http://www.parisclassictour.com/wcms/img/-size-17215-900-600.jpg]

tour.save
tour_tbl_id << tour.id
tour = Tour.new(
          name: "Paris Légendaire - 3H",
          description: "Un Circuit complet avec 2 arrêts",
          live: 1,
          guide_level: Faker::Number.between(1, 5),
          price: Faker::Number.between(40, 80),
          user_id: Faker::Number.between(user_tbl_id.first, user_tbl_id.last),
          address: "82 Boulevard de Clichy, 75018 Paris",
          language: "French"
          )
tour.photo_urls = %w[http://www.parisclassictour.com/wcms/img/-size-17206-900-600.jpg,
  http://www.parisclassictour.com/wcms/img/-size-17216-900-600.jpg,
  http://www.parisclassictour.com/wcms/img/-size-17217-900-600.jpg,
  http://www.parisclassictour.com/wcms/img/-size-17218-900-600.jpg]

tour.save
tour_tbl_id << tour.id

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

