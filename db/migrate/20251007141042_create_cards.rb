class CreateCards < ActiveRecord::Migration[8.0]
  def change
    create_table :cards do |t|
      t.references :game, null: false, foreign_key: true
      t.references :prize, null: false, foreign_key: true
      t.integer :position, null: false

      t.timestamps
    end
    
    add_index :cards, [:game_id, :position], unique: true
    add_index :cards, [:game_id, :prize_id]
  end
end
