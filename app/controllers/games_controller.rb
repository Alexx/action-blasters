class GamesController < ApplicationController
  def index
    @games = Game.where(user_id: current_user.id)
    @game = Game.new
    render :index
  end

  def create
    byebug
    @game.user_id = current_user.id
    @game.save
    redirect_to games_path
  end

  def show
    if current_user
      @game = Game.find(params[:id])
      @locations = Location.where(game_id: @game.id)
      @players = Player.where(game_id: @game.id)
    end
  end

  def edit
    @game = Game.find(params[:id])
    @players = Player.where(game_id: @game.id)
    @location = Location.find(@players[0].location_id)
    render :edit
  end

end
