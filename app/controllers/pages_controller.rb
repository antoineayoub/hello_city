class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def index

  end

  def home
    @tours = Tour.all
    @navbar_white = true
    @home_search = false
  end


end
