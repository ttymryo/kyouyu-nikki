class CreateDiaries < ActiveRecord::Migration[6.1]
  def change
    create_table :diaries do |t|
      t.integer :user_id, null: false
      t.text :body, null: false
      t.integer :emotion, null: false, default: 1
      t.boolean :add_commented, null: false, default: false
      t.integer :public_range, null: false, default: 0
      t.timestamps null: false
    end
  end
end
