class PlayersController < ApplicationController
  def index
    @players = Player.all
    render :index
  end

  def new
    @player = Player.new

    render :new
  end

  def create
    @player = Player.new(player_params)
    @player.user_id = current_user.id
    if @player.save
      flash[:notice] = "player successfully added!"
      redirect_to locations_path
    else
      render :new
    end
  end

  def show
    @player = Player.find(params[:id])
    @location = Location.find(@player.location_id)
    render :show
  end

  private
  def player_params
    params.require(:player).permit(:name, :health, :location_id)
  end
end
