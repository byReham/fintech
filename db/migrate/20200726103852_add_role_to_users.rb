class AddRoleToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :role, :int
    add_index :users, :role
  end
end
