class UpdateGamesTable < ActiveRecord::Migration[8.0]
  def change
    # Remove old columns
    remove_column :games, :name, :string
    remove_column :games, :description, :text
    remove_column :games, :price, :decimal
    
    # Add new columns
    add_column :games, :token, :string, null: false
    add_column :games, :played, :boolean, default: false
    add_column :games, :form_submitted, :boolean, default: false
    add_column :games, :played_at, :datetime
    add_column :games, :form_submitted_at, :datetime
    
    # Add unique index for token
    add_index :games, :token, unique: true
  end
end
