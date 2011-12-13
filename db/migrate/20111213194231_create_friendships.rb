class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.integer :id_user
      t.integer :id_friend

      t.timestamps
    end
  end
end
