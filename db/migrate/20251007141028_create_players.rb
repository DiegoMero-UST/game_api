class CreatePlayers < ActiveRecord::Migration[8.0]
  def change
    create_table :players do |t|
      t.references :game, null: false, foreign_key: true
      t.integer :picked_card, null: false
      t.datetime :picked_at

      t.timestamps
    end
    
    add_index :players, :picked_card
  end
end
