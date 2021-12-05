class AddTitleToTriviaGame < ActiveRecord::Migration[6.1]
  def change
    add_column(:trivia_games, :title, :string)
  end
end
