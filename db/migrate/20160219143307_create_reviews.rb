class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.references :user, index: true, foreign_key: true
      t.references :tour, index: true, foreign_key: true
      t.integer :rating
      t.string :review

      t.timestamps null: false
    end
  end
end
