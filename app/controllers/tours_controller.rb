class ToursController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
  search
    @markers = Gmaps4rails.build_markers(@tours) do |tour, marker|
      marker.lat tour.latitude
      marker.lng tour.longitude
    end
    @skip_footer = true
    @tours = @tours.order(:price).page
  end

  def index_user
    @user_tours = Tour.where("user_id = #{current_user.id}")
  end

  def new
    @tour = Tour.new
  end

  def getMarker
    i
  end

  def create
    @tour = Tour.new(tour_params)
    @tour.user = current_user
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

  def update_live
    @tour = Tour.find(params[:id])
    if @tour.update(tour_params)
      redirect_to user_path(current_user) # we redirect to his announce, well presented
    else
      render "users/#{current_user}"
    end
  end

  def show
    @tour = Tour.find(params[:id])
    @booking = Booking.new
    # Let's DYNAMICALLY build the markers for the view.
    @markers = Gmaps4rails.build_markers(@tour) do |tour, marker|
      marker.lat tour.latitude
      marker.lng tour.longitude
    end
    count_pending
  end

  def search
    if params[:address].present?
      @tours = Tour.near(params[:address], 1)
    else
      @tours = Tour.all
    end
  end

  private

  def tour_params
    params.require(:tour).permit(:name, :description, :live, :guide_level, :language, :address, :price, photos: [])
  end

end
