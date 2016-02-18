class AddNumberOfPeopleToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :nb_people, :integer
  end
end
