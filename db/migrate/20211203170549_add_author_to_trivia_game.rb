class AddAuthorToTriviaGame < ActiveRecord::Migration[6.1]
  def change
    add_column :trivia_games, :author, :string, null: true
  end
end