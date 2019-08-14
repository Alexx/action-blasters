class GamesController < ApplicationController
  def index
    if current_user
      @games = Game.where(user_id: current_user.id).order("id ASC")
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

  def enemy_attack(game_id, location_id)
    @location = Location.find(location_id)
    @enemies = Enemy.where(location_id: location_id).order("id DESC")

    @enemies.each do |enemy|
      players = Player.where(game_id: @game.id).where("health > ?", 0)
      if players.any?
        randomPlayer = players[rand(0..players.length-1)]
        randomPlayer.health -= 10
        if randomPlayer.health <= 0
          randomPlayer.alive = false
          randomPlayer.health = 0
        end
        randomPlayer.save
      end
    end
  end

  def attack
    @game = Game.find(params[:id])
    @players = Player.where(game_id: @game.id)
    @player = @players[@game.current_player]
    @enemies = Enemy.where(location_id: @player.location_id)
    @enemy = Enemy.where(selected: true).limit(1)[0]
    @enemy.health -= 20
    if @enemy.health <= 0
      @enemy.alive = false
      @enemy.health = 0
    end
    @enemy.save

    @game.current_player += 1

    while !(@game.current_player >= @players.length) && @players[@game.current_player].alive == false
      @game.current_player += 1
    end
    if @game.current_player >= @players.length
      self.enemy_attack(@game.id, @player.location_id)

      @game.current_player = 0
    end
    @game.save

    if self.check_for_player_win(@enemies)
      render :player_win
    elsif self.check_for_player_win(@players)
      render :enemy_win
    else
      redirect_to edit_game_path(id: @game.id)
    end
  end

  def check_for_player_win(enemies)
    win = true
    enemies.each do |enemy|
      if enemy.health > 0
        win = false
      end
    end
    win
  end
end
