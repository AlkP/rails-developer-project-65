class ReBuildAdminOnUser < ActiveRecord::Migration[8.1]
  def change
    remove_column :users, :admin, :boolean
    add_column :users, :admin, :boolean, default: true, null: false
  end
end
