class ToursController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @skip_footer = true

    # for price ranges
    # slider range > put 2 methods in private controllers
    @min_tour_price       = Tour.minimum(:price).to_i
    @max_tour_price       = Tour.maximum(:price).to_i
    @price_steps          = ((@max_tour_price - @min_tour_price) / 10).round
    @current_price_value  = @max_tour_price
    @min_tour_duration    = Tour.minimum(:tour_duration).to_i
    @max_tour_duration    = Tour.maximum(:tour_duration).to_i
    @duration_steps       = ((@max_tour_duration - @min_tour_duration) / 10).round
    @current_duration_value = @max_tour_price

    search_query = ""

    # method could work
    if  params[:tour_duration].to_i != 0
      search_query << "(tour_duration <= #{params[:tour_duration].to_i})"
      @current_duration_value = params[:tour_duration].to_i
    end

    if  params[:price].to_i != 0
      search_query << " AND (price <= #{params[:price].to_i})"
      @current_price_value = params[:price].to_i
    end

    params_hash = {
      provides_ticket: params[:provides_ticket],
      provides_car: params[:provides_car],
      provides_food: params[:provides_food],
      guide_level: params[:guide_level],
      language: params[:language]
    }

    params_hash.each do |key, value|

      if key == :guide_level
        value = params[:guide_level].to_i unless params[:guide_level].nil?
        search_query << " AND (#{key.to_s} = #{params[key]}) " unless value == "" || value == nil || value == 0
      else
        if value == 'true'
          value = true
        elsif value == 'false'
          value = false
        else
          value
        end
        search_query << " AND (#{key.to_s} = #{params[key]}) " unless value == "" || value == nil || value == 0
      end
    end

    if Tour.search_for(search_query).count >= 0
      @tours = Tour.search_for(search_query)
    else
      @tours = Tour.all
    end

    @tours = search(@tours)

    @markers = Gmaps4rails.build_markers(@tours) do |tour, marker|
      marker.lat tour.latitude
      marker.lng tour.longitude
    end

    count_pending
  end

  def search(tours)
    if params[:address].present?
      tours = tours.near(params[:address], 1)
    end
    tours
  end

  def guide_profile
    @tour = Tour.find(params[:id])
    @guide_tours = Tour.where("user_id = #{@tour.user_id}")

    tours_id = []
    @guide_tours.each { |tour| tours_id << tour.id }

    full_reviews = Review.all
    guide_reviews = []

    tours_id.each do |tour_id|
      full_reviews.each { |full_review| guide_reviews << full_review if full_review.tour_id == tour_id }
    end

    @reviews = guide_reviews
  end

  def index_user
    @user_tours = Tour.where("user_id = #{current_user.id}")
  end

  def new
    @tour = Tour.new
    count_pending
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
    count_pending
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
    @tours = Tour.all
    @tour = Tour.find(params[:id])
    @booking = Booking.new
    @review = Review.new
    # Let's DYNAMICALLY build the markers for the view.
    @markers = Gmaps4rails.build_markers(@tour) do |tour, marker|
      marker.lat tour.latitude
      marker.lng tour.longitude
    end
    @reviews = Review.where("tour_id = #{params[:id]}")
    count_pending
  end

  private

  def tour_params
    params.require(:tour).permit(:name, :description, :live, :guide_level, :language, :address, :price, photos: [])
  end
end
