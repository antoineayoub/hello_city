class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :tour

  validates :rating, presence: true
  validates :review, presence: true
end
