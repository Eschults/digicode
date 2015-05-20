class ChangeEmailNullInUsers < ActiveRecord::Migration
  def change
    change_column :users, :email, :string, default: ""
    change_column :users, :email, :string, null: true
  end
end
