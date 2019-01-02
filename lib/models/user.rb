require 'pry'

class User < ActiveRecord::Base
  has_many :user_workouts
  has_many :workouts, through: :user_workouts


  def self.login
    # this method should return a user object
    # that user object is the logged in user
    prompt = TTY::Prompt.new # TTY prompt
    choice = [
      {"Login" => -> do login end},
      {"Exit" => -> do exit end}
    ]
    input = prompt.ask("Username:")
    result = User.find_by(name: input)
    if !result
      system 'clear'
      prompt.select("No existing user:", choice)
    else
      result
    end
  end # end of login

  def self.enter_password(input) #result erased
    system 'clear'
    prompt = TTY::Prompt.new # TTY prompt
    arms = prompt.decorate('💪🏼')
    entered_password = prompt.mask("Password:", mask: arms)
    choice = [
      {"Re-enter Password" => -> do enter_password(input) end},
      {"Exit" => -> do exit end} # fix this bug
    ]

    found_user = User.find_by(name:input, password: entered_password)
    if !found_user
      system 'clear'
      prompt.select("Incorrect Password:", choice)
    end
  end

  # def self.create_account
  #   system 'clear'
  #   puts "Lets make a new account!"
  #   puts "Please choose a username:"
  #   new_username = gets.chomp
  #   while User.find_by(name: new_username) != nil # going to keep looping until we find a username that is not taken
  #     puts "Sorry! The user account already exist! Please choose another user"
  #     new_username = gets.chomp
  #   end
  #
  #   new_password = self.create_password
  #
  #   puts "Whats your age?"
  #   new_age = gets.chomp.to_i
  #
  #   puts "How much do you weigh in lbs?"
  #   new_weight = gets.chomp.to_i
  #
  #   puts "Welcome #{new_username}! You are currently #{new_age} years old, weighing #{new_weight}lbs!"
  #   User.create(name: new_username, age: new_age, weight: new_weight, password: new_password)
  #   puts "You have now successfully registered #{new_username}!"
  #   puts "Please log in to begin!"
  #   self.login
  # end # end of create account
  #
  def self.exit
    system 'clear'
    puts "Have a nice day!"
  end
  #
  # def self.create_password
  #   system 'clear'
  #   p1 = "create password"
  #   p2 = "must match p1"
  #   while p1 != p2
  #     puts "Please enter a password:"
  #     p1 = gets.chomp
  #
  #     puts "Please confirm your password:"
  #     p2 = gets.chomp
  #
  #     if p1 == p2
  #       puts "Password created!"
  #       return p1
  #     else
  #       puts "Password does not match, please remake password"
  #     end
  #   end
  # end # end of create password
  #
  def self.check_stats(user)
    system 'clear'
    puts "Name: #{user.name}"
    puts "ID: #{user.id}"
    puts "Age: #{user.age}"
    puts "Weight: #{user.weight}"
  end

  def self.create_workout
    system 'clear'
    puts "Please enter the name of the workout that you would like to add to the database"
    new_workout = gets.chomp
    Workout.create(exercise_name: new_workout)
  end

  def self.workout(user)
    system 'clear'
    prompt = TTY::Prompt.new # TTY prompt
    choices = Workout.all.map do |workout|
      {workout.exercise_name => -> do UserWorkout.create(user_id: user.id, workout_id: workout.id, day: Time.now) end}
    end
    prompt.select("What workout would you like to do?", choices)
    self.choices(user)
  end


  def self.update_stats(user)
    system 'clear'
    prompt = TTY::Prompt.new # TTY prompt
    choices = [
      {"Personal Info" => -> do self.update_personal_info(user) end},
      {"Workout Stats" => -> do self.update_workout_info(user) end},
      {"Back" => -> do self.choices(user) end}
    ]
    prompt.select("What would you like to update?", choices)
  end
  #
  def self.update_age(user)
    puts "What is your new age?"
    new_age = gets.chomp.to_i
    user.age = new_age
    user.save
    self.choices(user)
  end

  def self.update_weight(user)
    puts "What is your new weight?"
    new_weight = gets.chomp.to_i
    user.weight = new_weight
    user.save
    self.choices(user)
  end

  def self.update_sets(user)
    prompt = TTY::Prompt.new # TTY prompt
    puts "How many sets did you do?"
    new_set = gets.chomp.to_i
    system 'clear'
    find_user = UserWorkout.all.select { |workout| user.id == workout.user_id }
    choices = find_user.map do |uw|
      { "#{Workout.all.select { |workout| uw.workout_id == workout.id }[0].exercise_name} #{uw.day}" => -> do uw.update(sets: new_set) end}
    end
    prompt.select("Which workout would you like to update?", choices)
    self.choices(user)
  end

  def self.update_reps(user)
    prompt = TTY::Prompt.new # TTY prompt
    puts "How many reps did you do?"
    new_reps = gets.chomp.to_i
    find_user = UserWorkout.all.select { |workout| user.id == workout.user_id }
    system 'clear'
    choices = find_user.map do |uw|
      { "#{Workout.all.select { |workout| uw.workout_id == workout.id }[0].exercise_name} #{uw.day}" => -> do uw.update(reps: new_reps) end}
    end
    prompt.select("Which workout would you like to update?", choices)
    self.choices(user)
  end

  def self.update_personal_info(user)
    system 'clear'
    prompt = TTY::Prompt.new # TTY prompt
    choices = [
      {"Age" => -> do self.update_age(user) end},
      {"Weight" => -> do self.update_weight(user) end},
      {"Back" => -> do self.choices(user) end}
    ]
    prompt.select("What would you like to update?", choices)
  end

  def self.update_workout_info(user)
    system 'clear'
    prompt = TTY::Prompt.new # TTY prompt
    choices = [
      {"Update Sets" => -> do self.update_sets(user) end},
      {"Update Reps" => -> do self.update_reps(user) end}
    ]
    prompt.select("What would you like to update?", choices)
  end

  def self.choices(user)
    system 'clear'
    prompt = TTY::Prompt.new # TTY prompt
    choices = [
      {"Workout" => -> do self.workout(user) end}, #done
      {"Check Stats" => -> do self.check_stats(user) end}, #done
      {"Update Stats" => -> do self.update_stats(user) end},
      {"Create Workout" => -> do self.create_workout end} #done
    ]
    prompt.select("What would you like to do?", choices)
  end


end
