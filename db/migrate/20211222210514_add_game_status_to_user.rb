class AddGameStatusToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :gameStatus, :integer, default: 0
  end
end
