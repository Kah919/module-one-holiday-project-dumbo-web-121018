class ChangeUsersName < ActiveRecord::Migration[5.0]
  def self.up
    rename_table :User, :user_name
  end

  def self.down
    rename_table :user_name, :User
  end
end
