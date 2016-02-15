class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.timestamp :start_at
      t.string :status
      t.references :user, index: true, foreign_key: true
      t.references :tour, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
