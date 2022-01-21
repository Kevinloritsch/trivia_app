class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      t.string :session
      t.string :author

      t.timestamps
    end
  end
end
