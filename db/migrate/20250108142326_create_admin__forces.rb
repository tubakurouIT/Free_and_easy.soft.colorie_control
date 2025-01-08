class CreateAdminForces < ActiveRecord::Migration[6.1]
  def change
    create_table :admin__forces do |t|

      t.timestamps
    end
  end
end
