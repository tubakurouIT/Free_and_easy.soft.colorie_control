class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|
      t.integer :member_id, null: false
      t.string :name
      t.string :introduction
      t.timestamps
    end
  end
end
