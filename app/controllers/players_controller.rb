class PlayersController < ApplicationController
  def index
    @players = Player.all
    render :index
  end

  def new
    @game = Game.find(params[:game_id])
    @player = Player.new
    render :new
  end

  def create
    @game = Game.find(params[:game_id])
    @player = Player.new(player_params)
    @player.health = 100
    @player.alive = true
    if @player.save
      flash[:notice] = "player successfully added!"
      redirect_to game_path(@game)
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
    params.require(:player).permit(:name, :health, :location_id, :game_id)
  end
end
