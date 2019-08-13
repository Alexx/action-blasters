class CreatePlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :players do |t|
      t.string :name
      t.integer :health
      t.integer :level
      t.integer :location_id
      t.integer :game_id

      t.timestamps
    end
  end
end
