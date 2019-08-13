class AddForeignKeyForPlayers < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :players, :locations
    add_foreign_key :enemies, :locations
  end
end
