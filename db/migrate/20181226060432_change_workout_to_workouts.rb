class ChangeWorkoutToWorkouts < ActiveRecord::Migration[5.0]
  def change
    rename_table :workout, :workouts
  end
end
