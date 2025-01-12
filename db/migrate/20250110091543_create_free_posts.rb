class CreateFreePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :free_posts do |t|
      t.integer :member_id, null: false
      t.integer :group_id
      t.text :body, null: false
      t.timestamps
    end
  end
end
