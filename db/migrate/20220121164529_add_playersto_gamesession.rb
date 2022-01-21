class AddPlayerstoGamesession < ActiveRecord::Migration[6.1]
  def change
    add_column :rooms, :players, :string
  end
end
