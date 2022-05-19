class AddPlayerstoGamesession < ActiveRecord::Migration[6.1]
  def change
    add_column :Rooms, :players, :string
  end
end
