class BookingsController < ApplicationController
  def create
    @user = current_user
    @tour = Tour.find(params[:tour_id])
    @booking = Booking.new(booking_params)
    @booking.status = "pending_guide_validation"  #should put default in migration?
    @booking.user_id = @user.id
    @tour_id = @tour.id

    if @booking.save
      redirect_to user_path(current_user) # not working now, to be checked tomorrow
    else
      redirect_to tour_path(@tour) # should flash error message
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:start_at)
  end

end
