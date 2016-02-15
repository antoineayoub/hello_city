class Booking < ActiveRecord::Base
  belongs_to :user
  belongs_to :tour

  validates :start_at, presence: true
  validates :status, presence: true
end
