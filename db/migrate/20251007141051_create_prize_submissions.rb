class CreatePrizeSubmissions < ActiveRecord::Migration[8.0]
  def change
    create_table :prize_submissions do |t|
      t.references :player, null: false, foreign_key: true
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.string :address1, null: false
      t.string :address2
      t.string :city, null: false
      t.string :state, null: false
      t.string :country, null: false
      t.string :zip, null: false

      t.timestamps
    end
    
    add_index :prize_submissions, :email
    add_index :prize_submissions, :player_id, unique: true, name: 'unique_prize_submissions_player_id'
  end
end
