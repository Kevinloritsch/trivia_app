class Rooms < ActiveRecord::Migration[6.1]
  def change
    create_table :Rooms do |t|
      t.string :session
      t.string :message
      t.string :author

      t.timestamps
    end
  end
end
