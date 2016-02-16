class ToursController < ApplicationController

  def index
    @tours = Tour.all
  end

  def index_user
    @user_tours = Tour.where("user_id = #{current_user.id}")
  end

  def new
    @tour = Tour.new
  end

  def create
    @tour = Tour.new(tour_params, user: current_user)
    @tour.user_id = current_user.id
    if @tour.save
      redirect_to tour_path(@tour) # we redirect to his announce, well presented
    else
      render :new
    end
  end

  def edit
    @tour = Tour.find(params[:id])
  end

  def update
    @tour = Tour.find(params[:id])
    if @tour.update(tour_params)
      redirect_to tour_path(@tour) # we redirect to his announce, well presented
    else
      render :new
    end

  end

  def show
    @tour = Tour.find(params[:id])
    @booking = Booking.new
  end

  private

  def tour_params
    params.require(:tour).permit(:name, :description, :live, :guide_level, :language, :address, :price)
  end

end