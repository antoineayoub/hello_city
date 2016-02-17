class BookingsController < ApplicationController
  def create
    @user = current_user
    @tour = Tour.find(params[:tour_id])
    @booking = Booking.new(booking_params)
    @booking.status = "pending"  #should put default in migration?
    @booking.user_id = @user.id
    @booking.tour_id = @tour.id

    if @booking.save
      redirect_to user_path(@user) # not working now, to be checked tomorrow
    else
      redirect_to tour_path(@tour) # should flash error message
    end
  end

  def update
    @booking = Booking.find(params[:id])
    if @booking.update(booking_params)
      redirect_to user_path(@booking.user)
    else
      render :show
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:start_at, :status)
  end

end
