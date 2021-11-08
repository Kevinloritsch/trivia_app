class ChangeTriviaGame < ActiveRecord::Migration[6.1]
  def change
    remove_column(:trivia_games, :answer)
    remove_column(:trivia_games, :question)
    add_column(:trivia_games, :data, :string)
  end
end
