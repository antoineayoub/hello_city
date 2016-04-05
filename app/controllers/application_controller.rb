class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_locale

  before_action :authenticate_user!, :count_pending

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale == I18n.default_locale ? nil : I18n.locale }
  end
  private
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
