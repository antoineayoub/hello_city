class Tour < ActiveRecord::Base
  belongs_to :user
  has_many :bookings

  validates :price, presence: true
  validates :name, presence: true
  validates :description, presence: true
  validates :language, presence: true
  validates :address, presence: true
  validates :guide_level, presence: true
  # add details user info to validate the form (phone num...)
end
