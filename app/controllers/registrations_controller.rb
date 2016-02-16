class RegistrationsController < Devise::RegistrationsController

  private

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :summary, :phone_number, :birth_date, :email, :password, :user_picture)
  end
end
