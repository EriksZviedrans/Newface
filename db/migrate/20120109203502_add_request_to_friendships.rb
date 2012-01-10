class AddRequestToFriendships < ActiveRecord::Migration
  def change
    add_column :friendships, :request, :integer
  end
end
