#require 'bcrypt-ruby'
class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :fullname
      t.string :login
      t.string :password_hash
      t.string :password_salt
      t.string :mail
      t.integer :facebookid, :limit => 8
      t.timestamps
    end
  end
end
