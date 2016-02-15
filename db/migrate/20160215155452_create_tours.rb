class CreateTours < ActiveRecord::Migration
  def change
    create_table :tours do |t|
      t.string :name
      t.text :description
      t.boolean :live
      t.integer :guide_level
      t.string :language
      t.string :address
      t.decimal :price
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
