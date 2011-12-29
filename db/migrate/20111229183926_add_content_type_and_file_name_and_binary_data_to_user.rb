class AddContentTypeAndFileNameAndBinaryDataToUser < ActiveRecord::Migration
  def change
    add_column :users, :content_type, :string
    add_column :users, :file_name, :string
    add_column :users, :binary_data, :binary
  end
end
