class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      t.references :follower, null: false
      t.references :followed, null: false

      t.timestamps
    end
   add_index :relationships, [:follower_id, :followed_id],                unique: true
  end
end
