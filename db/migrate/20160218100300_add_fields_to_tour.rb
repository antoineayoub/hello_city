class AddFieldsToTour < ActiveRecord::Migration
  def change
    add_column :tours, :provides_car, :boolean
    add_column :tours, :provides_ticket, :boolean
    add_column :tours, :provides_food, :boolean
  end
end
