class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
      t.integer :user_id, null: false
      t.integer :diary_id, null: false

      t.timestamps null: false
    end
    add_index :favorites, [:user_id, :diary_id],                unique: true
  end
end
