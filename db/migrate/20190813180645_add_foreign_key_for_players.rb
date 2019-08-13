class AddForeignKeyForPlayers < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :players, :games
    add_foreign_key :locations, :games
    add_foreign_key :games, :users
    add_foreign_key :players, :locations
    add_foreign_key :enemies, :locations
  end
end
