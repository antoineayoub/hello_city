class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :summary, :text
    add_column :users, :user_picture, :string
    add_column :users, :phone_number, :string
    add_column :users, :birth_date, :date
  end
end
