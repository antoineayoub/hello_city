class Tour < ActiveRecord::Base
  belongs_to :user
  has_many :bookings

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
end
