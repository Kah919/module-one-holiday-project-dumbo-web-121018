require 'pry'
class CommandLineInterface
  attr_accessor :user

  def greet
    system 'clear'
    prompt = TTY::Prompt.new
    choices = [
      {"Login" => -> do self.login end},
      {"Create Account" => -> do User.create_account end},
      {"Exit" => -> do User.exit end}
    ]
      prompt.select("Welcome to the open BETA Workout Tracker!!", choices)
  end

  def run
    greet
  end

  def login
    prompt = TTY::Prompt.new
    self.user = User.login #saving the CLI user to what the User logs into
    password = User.enter_password(self.user.name)
    # prompt.select("Hello #{self.user.name}!! What would you like to do today?", "Hi")#what goes here)
    # move User.login logic here
    # save user object to self.user
    User.choices(self.user)
  end


end
