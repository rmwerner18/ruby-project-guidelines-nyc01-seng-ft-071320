require 'pry'
require "pp"

class CLI

    def main_functions(user)
        User.show_choices
        choice = gets.chomp
        if choice == "1"
            searched_events = Event.search
            if searched_events
                user.add_from_searched_events?(searched_events)
            end
            self.main_functions(user)
        elsif choice == "2"
            p PP.pp(user.events)
            self.main_functions(user)
        elsif choice == "9999"
            puts "Thank you, come again!"
        else puts "Please enter a valid choice"
            self.main_functions(user)
        end 
     end

    def start
        user = User.login_or_create
        if user
            self.main_functions(user)                  
        else puts "Please enter a valid username/password"
        end
    end
end