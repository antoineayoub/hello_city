class AddPriceToBooking < ActiveRecord::Migration
  def change
    add_column :bookings, :price, :decimal
  end
end
