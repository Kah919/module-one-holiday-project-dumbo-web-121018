class AddWorkoutIdToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :workout_id, :integer
  end
end
