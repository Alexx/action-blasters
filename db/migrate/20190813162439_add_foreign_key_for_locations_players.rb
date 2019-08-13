class AddForeignKeyForLocationsPlayers < ActiveRecord::Migration[5.2]
  def change
    add_column :players, :user_id, :integer
    add_column :locations, :user_id, :integer
    add_foreign_key :players, :users
    add_foreign_key :locations, :users

  end
end
