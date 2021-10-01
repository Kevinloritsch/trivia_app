class CreateTriviaGames < ActiveRecord::Migration[6.1]
  def change
    create_table :trivia_games do |t|
      t.string :question
      t.string :answer

      t.timestamps
    end
  end
end
