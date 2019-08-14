class GamesController < ApplicationController
  def index
    if current_user
      @games = Game.where(user_id: current_user.id)
    end
    render :index
  end

  def create
    @game = Game.new
    @game.user_id = current_user.id
    @game.current_player = 0
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
    @enemies = Enemy.where(location_id: @location.id).order("id DESC")
    render :edit
  end

  def enemy_attack
    @game = Game.find(params[:id])
    @players = Player.where(game_id: @game.id)
    @player = @players[@game.current_player]
    @enemy = Enemy.where(selected: true).limit(1)[0]
    @player.health -= 10
    @player.save
    redirect_to edit_game_path(id: @game.id)

  end

  def attack
    @game = Game.find(params[:id])
    @players = Player.where(game_id: @game.id)
    @player = @players[@game.current_player]
    @enemy = Enemy.where(selected: true).limit(1)[0]
    @enemy.health -= 10
    @enemy.save

    @game.current_player += 1
    if @game.current_player >= @players.length
      @game.current_player = 0
    end
    @game.save

    redirect_to edit_game_path(id: @game.id)

  end
end
