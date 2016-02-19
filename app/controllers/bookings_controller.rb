class BookingsController < ApplicationController
  def create
    @user = current_user
    @tour = Tour.find(params[:tour_id])
    @booking = Booking.new(booking_params)
    @booking.status = "pending"  #should put default in migration?
    @booking.user = @user
    @booking.tour = @tour
    if @booking.save
      redirect_to user_path(@user) # not working now, to be checked tomorrow
    else
      redirect_to tour_path(@tour) # should flash error message
    end
  end

  def update
    @booking = Booking.find(params[:id])
    @status = @booking.status
    if @booking.update(booking_params)
      respond_to do |format|
        format.html { redirect_to user_path(@booking.user) }
        format.js  # <-- will render `app/views/reviews/create.js.erb`
      end
    else
      respond_to do |format|
        format.html { render :show }
        format.js  # <-- idem
      end
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:start_at, :status, :nb_people)
  end

end
