class ToursController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    search
    @markers = Gmaps4rails.build_markers(@tours) do |tour, marker|
      marker.lat tour.latitude
      marker.lng tour.longitude
    end
    @skip_footer = true

    params_hash = {
      guide_level: params[:guide_level],
      price: params[:price],
      provides_car: params[:provides_car],
      provides_ticket: params[:provides_ticket],
      provides_food: params[:provides_food],
      tour_duration: params[:tour_duration],
      language: params[:language]
    }
    search_query = ""

    if  params[:tour_duration].to_i != 0
      search_query << "(tour_duration <= #{params[:tour_duration].to_i})"
    end

    if  params[:price].to_i != 0
      search_query << "(price <= #{params[:price].to_i})"
    end

    params_hash.each do |key, value|
      search_query << " AND (#{key.to_s} = #{params_hash[key]}) " unless params_hash[key] = "" || params_hash[key] = nil
    end

    if  Tour.search_for(search_query).count >= 0
      @tours = Tour.search_for(search_query)
    else
      @tours = Tour.all
    end
end


  def index_user
    @user_tours = Tour.where("user_id = #{current_user.id}")
  end

  def new
    @tour = Tour.new
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
