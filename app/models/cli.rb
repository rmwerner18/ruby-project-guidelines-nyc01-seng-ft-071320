require 'pry'

class CLI
    def start
        user = User.login
        if user
            puts "Would you like to search for events? (yes/no)"
            response = gets.chomp
            if response == "yes"
                puts "Please specify a city"
                city = gets.chomp
                event = Event.find_by_city(city)
                binding.pry
            end

        else puts "Please enter a valid username/password"
        end
    end
end