class UsersController < ApplicationController

  def show
    @not_cancelled_bookings = Booking.where("status <> 'cancelled' AND user_id=#{params[:id]}")
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end



  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :summary, :phone_number, :birth_date, :email, :user_picture, :picture)
  end
end
