class AddDigicodeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :digicode, :string
  end
end
