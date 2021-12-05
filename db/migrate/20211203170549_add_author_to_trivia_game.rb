class AddAuthorToTriviaGame < ActiveRecord::Migration[6.1]
  def change
<<<<<<< HEAD
    add_column(:trivia_games, :author, :string)
=======
    add_column :trivia_games, :author, :string, null: true
>>>>>>> 25f234b04e74994a449194c9d057cbc931fde580
  end
end