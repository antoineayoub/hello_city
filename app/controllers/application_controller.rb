class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def count_pending
    @nb_pending = 0
    unless current_user.nil?
      current_user.tours.each do |tour|
        tour.bookings.each do |booking|
          if booking.status == "pending"
            @nb_pending += 1
          end
        end
      end
    end
  end
end
