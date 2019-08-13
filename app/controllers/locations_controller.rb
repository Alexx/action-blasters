class LocationsController < ApplicationController
  def index
    if current_user
      @locations = Location.where(user_id: current_user.id)
      @players = Player.where(user_id: current_user.id)
    end
    render :index
  end

  def new
    @location = Location.new
    render :new
  end

  def create
    @location = Location.new(location_params)
    @location.user_id = current_user.id
    if @location.save
      flash[:notice] = "Location successfully added!"
      redirect_to locations_path
    else
      render :new
    end
  end

  private
  def location_params
    params.require(:location).permit(:name)
  end
end
