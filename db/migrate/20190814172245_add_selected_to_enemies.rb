class AddSelectedToEnemies < ActiveRecord::Migration[5.2]
  def change
    add_column(:enemies, :selected, :boolean)
  end
end
