class CreateWorkout < ActiveRecord::Migration[5.0]
  def change
    create_table :workout do |t|
      t.string :exercise_name
    end
  end
end
