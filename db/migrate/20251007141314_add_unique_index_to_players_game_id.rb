class AddUniqueIndexToPlayersGameId < ActiveRecord::Migration[8.0]
  def change
    add_index :players, :game_id, unique: true, name: 'unique_players_game_id'
  end
end
