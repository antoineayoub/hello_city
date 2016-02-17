class ChangeDateFormatOfBookings < ActiveRecord::Migration
  def change
    change_column :bookings, :start_at, :date
  end
end
