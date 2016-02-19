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
Tour.destroy_all

# CREATE USER
user_tbl_id = []
tour_tbl_id = []
tbl_pic = []
cpt = 0

tbl_pic = %w(http://elfnordics.com/mediabank/var/resizes/e.l.f.-Scandinavia-Staff/PROFILE-Celine-01-square.jpg
http://whysquare.co.nz/wp-content/uploads/2013/07/profile_square3-270x270.jpg
http://rorganize.it/uploads/person/picture/89/person_profile_avatar_face_shrunk_square_200x200.jpg
http://static1.squarespace.com/static/53af1c83e4b0b3e1fc2000bd/53b0a50be4b0d621f6aa6072/5636475be4b0507883434959/1446397788072/Randy+Krum+Profile+Photo+square.jpg
http://www.glamour.com/images/fashion/2013/06/sophia-chabbott-profile-square-w352.jpg
http://www.automationheroes.com/wp-content/uploads/2014/01/Business-Profile-Pic-square.jpg
http://woogmasterstudio.com/wp-content/uploads/2015/04/square-alex-profile.jpg
https://www.business2blogger.com/wp-content/uploads/2014/04/Profile-Big-Square.jpg.jpg
https://s3.amazonaws.com/steady-static/img/provider/bcvOrym6Jp90TPVGjBdR4s8BLzOgL2YzMHX9_profile_square.jpg
https://nianow.com/sites/nianow.com/files/user-files/user-7338/profile/square-profile.jpg)

10.times do
  first_name = Faker::Name.first_name
  user = User.new(
          first_name: first_name,
          last_name: Faker::Name.last_name,
          email: Faker::Internet.email(first_name),
          password: '00000000',
          summary: Faker::Lorem.paragraph
          )

  user.picture_url = tbl_pic[cpt]
  user.save
  user_tbl_id << user.id
  cpt = cpt + 1
  puts "Id: #{user.id} Email: #{user.email} Password: 00000000"
end

# CREATE TOUR
photo_urls = %w(http://www.parisclassictour.com/wcms/img/-size-17206-900-600.jpg,
  http://www.parisclassictour.com/wcms/img/-size-17207-900-600.jpg,
  http://www.parisclassictour.com/wcms/img/-size-17208-900-600.jpg,
  http://www.parisclassictour.com/wcms/img/-size-17209-900-600.jpg,
  http://www.parisclassictour.com/wcms/img/-size-17210-900-600.jpg,
  http://www.parisclassictour.com/wcms/img/-size-17211-900-600.jpg,
  http://www.parisclassictour.com/wcms/img/-size-17212-900-600.jpg,
  http://www.parisclassictour.com/wcms/img/-size-17213-900-600.jpg,
  http://www.parisclassictour.com/wcms/img/-size-17214-900-600.jpg,
  http://www.parisclassictour.com/wcms/img/-size-17215-900-600.jpg,
  http://www.parisclassictour.com/wcms/img/-size-17216-900-600.jpg,
  http://www.parisclassictour.com/wcms/img/-size-17217-900-600.jpg,
  http://www.parisclassictour.com/wcms/img/-size-17218-900-600.jpg,
  http://www.parisclassictour.com/wcms/img/-size-17219-900-600.jpg,
  http://www.parisclassictour.com/wcms/img/-size-17220-900-600.jpg,
  http://www.parisclassictour.com/wcms/img/-size-17221-900-600.jpg,
  http://www.parisclassictour.com/wcms/img/-size-17222-900-600.jpg)
tour_names = ["Oh ville Lumière","Paris est magique","Le meilleur de Paris",
  "Le Paris des parisiens","Au fond des parisiennes","Paris by Night",
  "Les plus beaux monuments","Ballade en vélo!","Visite Fabuleuse",
  "Apprendre sur Paris","Visite avec un parisien"]
tour_addresses = ["Place de la Bastille Paris",
  "Place Vendôme Paris",
  "Place de la Concorde Paris",
  "Square des Innocents Paris","Place du trocadero paris",
  "Hôtel Matignon Paris","Palais de la Légion d'honneur Paris",
  "Palais du Luxembourg Paris","Hôtel de Sens Paris","Palais Brongniart Paris",
  "Temple protestant de l'Oratoire du Louvre Paris","Grande Mosquée de Paris Paris",
  "Église Saint-Eustache Paris","Église Saint-Louis-des-Invalides Paris",
  "Basilique du Sacré-Cœur de Montmartre Paris"]

20.times do
  tour = Tour.new(
            name: tour_names.sample,
            description: Faker::Lorem.paragraph,
            live: 1,
            guide_level: Faker::Number.between(1, 5),
            price: Faker::Number.between(40, 80),
            user_id: Faker::Number.between(user_tbl_id.first, user_tbl_id.last),
            address: tour_addresses.sample,
            language: ["French","English","Chinese","Spanish"].sample,
            tour_duration: (1..12).to_a.sample,
            provides_food: [true, false].sample,
            provides_car: [true, false].sample,
            provides_ticket: [true, false].sample
            )
  tour.photo_urls = photo_urls.sample(3)
  tour.save
  tour_tbl_id << tour.id
end

# CREATE BOOKINGS

80.times do
  tour_id = Faker::Number.between(tour_tbl_id.first, tour_tbl_id.last)
  user_id = Faker::Number.between(user_tbl_id.first, user_tbl_id.last)
  unless user_id == Tour.find(tour_id).user_id
    booking = Booking.new(
      start_at: Faker::Time.between(DateTime.now, DateTime.now + 100),
      status: 'pending',
      user_id: user_id,
      tour_id: tour_id,
      price: Tour.find(tour_id).price,
      nb_people: (1..10).to_a.sample
      )
    booking.save
  end
end

