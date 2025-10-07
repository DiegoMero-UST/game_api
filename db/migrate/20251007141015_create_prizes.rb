class CreatePrizes < ActiveRecord::Migration[8.0]
  def change
    create_table :prizes do |t|
      t.string :name, null: false
      t.text :description
      t.boolean :active, default: true

      t.timestamps
    end
    
    add_index :prizes, :name, unique: true
  end
end
