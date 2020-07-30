require 'pry'
require "pp"

class CLI

    def self.main_functions(user)
        User.show_choices
        choice = gets.chomp
        if choice == "1"
            User.choice_1_main_functions(user)
            self.main_functions(user)           
        elsif choice == "2"
            User.choice_2_main_functions(user)
            self.main_functions(user)
        elsif choice == "3"
            User.choice_3_main_functions(user)
            self.main_functions(user)
        elsif choice == "4"
            puts "You are now in MyEvents!"
            User.choice_4_main_functions(user)
            self.main_functions(user)
        elsif choice == "9999"
            puts "Thank you, come again!"
        else puts "Please enter a valid choice"
            self.main_functions(user)
        end 
     end

    def start
        puts "Welcome to our app!"
        user = User.login_or_create
        CLI.main_functions(user)                  
    end
end