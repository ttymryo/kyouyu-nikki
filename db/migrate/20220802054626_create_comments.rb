class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.integer :user_id, null: false
      t.integer :diary_id, null: false
      t.text :body, null: false

      t.timestamps null: false
    end
  end
end
