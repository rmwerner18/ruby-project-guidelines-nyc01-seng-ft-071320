require_relative '../config/environment'

user = User.first
cli = CLI.new
# cli.start
CLI.main_functions(user)