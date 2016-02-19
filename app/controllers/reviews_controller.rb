class ReviewsController < ApplicationController

  def create
    @review = Review.new(review_params)
    @review.user = current_user
    @review.tour = Tour.find(params[:tour_id])
    if @review.save
      redirect_to user_path(current_user)
    else
      redirect_to tour_path(@review.tour)
    end
  end

  private


  def review_params
    params.require(:review).permit(:rating, :review)
  end

end
