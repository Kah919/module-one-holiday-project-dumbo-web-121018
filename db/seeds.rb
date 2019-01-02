
User.destroy_all
Workout.destroy_all
UserWorkout.destroy_all

kah = User.create(name: "Kah", age: 25, weight: 150, password: "kah")
ludy = User.create(name: "Ludy", age:25, weight: 93, password: "ludy")
sion = User.create(name: "Sion", age: 30, weight: 250, password: "sion")
doggy = User.create(name: "Doggy", age: 5, weight: 30, password: "doggy")
batman = User.create(name: "Batman", age: 30, weight: 210, password: "batman")
bruce = User.create(name: "Bruce Wayne", age: 30, weight: 210, password: "bruce")

pullups = Workout.create(exercise_name: "Pull-Ups")
pushups = Workout.create(exercise_name: "Push-Ups")
squats = Workout.create(exercise_name: "Squats")

uw1 = UserWorkout.create(user_id: kah.id, workout_id: pullups.id)
uw2 = UserWorkout.create(user_id: kah.id, workout_id: pushups.id)
uw3 = UserWorkout.create(user_id: batman.id, workout_id: squats.id)





binding.pry
true
