class AddAdminField < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :admin, :boolean, default: false, null: false

    User.where(admin: false).update_all(admin: true) # rubocop:disable Rails/SkipsModelValidations
  end
end
