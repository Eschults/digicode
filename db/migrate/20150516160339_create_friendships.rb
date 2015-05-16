class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.references :sender, index: true
      t.references :receiver, index: true
      t.boolean :accepted

      t.timestamps null: false
    end
  end
end
