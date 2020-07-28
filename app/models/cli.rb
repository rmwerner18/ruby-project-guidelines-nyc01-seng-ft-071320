require 'pry'

class CLI
    def start
        puts "Welcome to our app! Would you like to sign up or log in?"
        action = gets.chomp
        if action == "sign up"
            user = User.sign_up
        elsif action == "log in"
            user = User.login
        end
        if user
            puts "Would you like to search for events? (yes/no)"
            response = gets.chomp
            if response == "yes"
                a = Event.search
                p a
                a.each do |event|
                    user.add_from_searched_events(event)
                end
            end
            puts "Would you like to see all of MyEvents (yes/no)"
            response = gets.chomp
            if response == "yes"
                p user.events
            end
            puts "Would you like to exit? (yes/no)"
            response = gets.chomp
            if response == "yes"
                puts "Thank you, come again!"
            elsif response == "no"
                puts 'too bad'
            end               
        else puts "Please enter a valid username/password"
        end
    end
end