class ChangeUserNames < ActiveRecord::Migration[5.0]
  def change
    rename_table :user_name, :username
  end
end
