class CreateGroupMembers < ActiveRecord::Migration[6.1]
  def change
    create_table :group_members do |t|
      t.references :member, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true
      t.integer :status, null: false, default: 0

      t.timestamps
      t.index [:member_id, :group_id], unique: true
    end
  end
end
