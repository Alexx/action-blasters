class EnemiesController < ApplicationController

  def create
    @location = Location.find(params[:location_id])
    @enemy = Enemy.new({:type_of => "Skeleton", :health => 100})
    @enemy.location_id = @location.id
    if @enemy.save
      flash[:notice] = "Enemy successfully added!"
      redirect_to game_path(id: @location.game_id)
    else
      render :new
    end
  end

  def index
    "got here"
  end

  private
  def enemy_params
    params.require(:enemy).permit(:name, :location_id)
  end
end
