module ToursHelper
  attr_reader :to_boolean

  def reviewable?(tour)
    # current_user = validated_booking.user_id && review.user_id does not exist
    if current_user.nil?
      false
    else
      # can be simplified with 1 sql query
      nb_booking_accepted = Booking.where("tour_id = #{tour.id} and user_id = #{current_user.id} and status = 'accepted'").size
      nb_reviews = Review.where("#{current_user.id} = user_id and tour_id = #{tour.id}").size
      nb_booking_accepted > 0 && nb_reviews != nb_booking_accepted ? true : false
    end
  end

end
