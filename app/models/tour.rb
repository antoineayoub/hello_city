class Tour < ActiveRecord::Base
  belongs_to :user
  has_many :bookings
  has_many :reviews, dependent: :destroy

  has_attachments :photos, maximum: 5, accept: [:jpg, :png]

  validates :price, presence: true
  validates :name, presence: true
  validates :description, presence: true
  validates :language, presence: true
  validates :address, presence: true
  validates :guide_level, presence: true
  validates :user_id, presence: true
  # add details user info to validate the form (phone num...)
  #
  geocoded_by :address
  after_validation :geocode, if: :address_changed?

scoped_search on: [:guide_level, :price, :provides_car, :provides_ticket, :provides_food, :tour_duration, :language]
paginates_per 10
end
