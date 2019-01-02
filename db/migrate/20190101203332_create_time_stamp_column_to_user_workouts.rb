class CreateTimeStampColumnToUserWorkouts < ActiveRecord::Migration[5.0]
  def change
    add_column :user_workouts, :day, :date
  end
end
