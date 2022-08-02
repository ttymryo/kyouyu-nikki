class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      t.integer :user_id, null: false
      t.integer :follow_id, null: false

      t.timestamps
    end
   add_index :relationships, [:user_id, :follow_id],                unique: true
  end
end
