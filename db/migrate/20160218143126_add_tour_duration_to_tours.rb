class AddTourDurationToTours < ActiveRecord::Migration
  def change
    add_column :tours, :tour_duration, :integer
  end
end
