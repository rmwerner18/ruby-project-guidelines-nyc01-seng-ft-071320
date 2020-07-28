require 'pry'

class CLI
    def start
        user = User.login
        if user
            puts "Would you like to search for events? (yes/no)"
            response = gets.chomp
            if response == "yes"
                a = Event.search
                p a
                # binding.pry
            end

        else puts "Please enter a valid username/password"
        end
    end
end