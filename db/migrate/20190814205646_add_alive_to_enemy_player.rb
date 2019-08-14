class AddAliveToEnemyPlayer < ActiveRecord::Migration[5.2]
  def change
    add_column(:enemies, :alive, :boolean)
    add_column(:players, :alive, :boolean)
  end
end
