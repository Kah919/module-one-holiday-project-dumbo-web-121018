class ChangeUsernameToUsers < ActiveRecord::Migration[5.0]
  def change
    rename_table :username, :users
  end
end
