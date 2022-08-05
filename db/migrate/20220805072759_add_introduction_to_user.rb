class AddIntroductionToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :introduction, :text, default: "",null: false
    add_column :users, :is_public, :boolean, default: true, null: false
  end
end
