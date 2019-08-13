class RemoveAndAddTypeColumn < ActiveRecord::Migration[5.2]
  def change
    remove_column(:enemies, :type, :string)
    add_column(:enemies, :type_of, :string)
  end
end
