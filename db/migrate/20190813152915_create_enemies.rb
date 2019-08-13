class CreateEnemies < ActiveRecord::Migration[5.2]
  def change
    create_table :enemies do |t|
      t.integer :location_id
      t.integer :health
      t.string :type

      t.timestamps
    end
  end
end
