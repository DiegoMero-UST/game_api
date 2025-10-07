class CreateGames < ActiveRecord::Migration[8.0]
  def change
    create_table :games do |t|
      t.string :token, null: false, index: { unique: true }
      t.boolean :played, default: false
      t.boolean :form_submitted, default: false
      t.datetime :played_at
      t.datetime :form_submitted_at

      t.timestamps
    end
  end
end
