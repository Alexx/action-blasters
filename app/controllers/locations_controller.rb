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
    @game = Game.find(params[:game_id])
    render :new
  end

  def create
    @game = Game.find(params[:game_id])
    @location = Location.new(location_params)
    if @location.save
      flash[:notice] = "Location successfully added!"
      redirect_to enemies_path(location_id: @location.id)
    else
      render :new
    end
  end

  private
  def location_params
    params.require(:location).permit(:name, :game_id)
  end
end
