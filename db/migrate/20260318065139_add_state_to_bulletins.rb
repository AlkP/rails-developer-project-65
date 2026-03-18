class AddStateToBulletins < ActiveRecord::Migration[8.1]
  def change
    add_column :bulletins, :state, :string
    add_index :bulletins, :state
    Bulletin.update_all(state: 'draft')
  end
end
