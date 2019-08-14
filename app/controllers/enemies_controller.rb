class EnemiesController < ApplicationController

  def index
    @location = Location.find(params[:location_id])
    enemy_types = ["Skeleton", "Zombie", "Ghoul", "Kim Jong Un"]

    rand(1..5).times do
      @enemy = Enemy.new({:type_of => enemy_types[rand(0..3)], :health => 100})
      @enemy.location_id = @location.id
      @enemy.selected = false
      if @enemy.save
        flash[:notice] = "Enemy successfully added!"
      end
    end
    redirect_to game_path(id: @location.game_id)
  end

  def update
    @selected_enemies = Enemy.where(selected: true)
    @selected_enemies.each do |enemy|
      enemy.selected = false
      enemy.save
    end

    @location = Location.find(params[:location_id])
    @enemy = Enemy.find(params[:id])
    @enemy.selected = true
    @enemy.save
    redirect_to edit_game_path(id: @location.game_id)
  end

  private
  def enemy_params
    params.require(:enemy).permit(:name, :location_id)
  end
end
