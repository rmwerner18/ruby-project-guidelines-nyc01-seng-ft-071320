require "pp"

class User < ActiveRecord::Base
    has_many :event_users
    has_many :events, through: :event_users
     
    def self.login_or_create
        puts "Welcome to our app! Would you like to sign up or log in?"
        action = gets.chomp
        puts "What is your first name?"
        first_name = gets.chomp
        puts "What is your last name?"
        last_name = gets.chomp
        puts "What is your password"
        password = gets.chomp
        if action == "sign up"
            user = User.create(first_name: first_name, last_name: last_name, password: password)
        elsif action == "log in"
            user = User.find_by(first_name: first_name, last_name: last_name, password: password)
        end
    end

    def add_to_my_events(event)
        EventUser.create(user: self, event: event)
    end

    def add_from_searched_events?(searched_events)
        searched_events.each do |event|
            puts "Would you like to add this event to MyEvents? (yes/no)"
            answer = gets.chomp
            if answer == "yes"
                self.add_to_my_events(event)
            end
        end
    end

    def search_events
        puts "Would you like to search for events? (yes/no)"
        response = gets.chomp
        if response == "yes"
            a = Event.search
            p a
        end
    end   

    def see_my_events?
        puts "Would you like to see all of MyEvents (yes/no)"
        response = gets.chomp
        if response == "yes"
            p self.events
        end
    end

    def exit?
        puts "Would you like to exit? (yes/no)"
        response = gets.chomp
        if response == "yes"
            puts "Thank you, come again!"
        elsif response == "no"
            puts 'too bad'
        end
    end

    def self.show_choices
        puts "What would you like to do? (enter number)"
        puts "1: Search events by city and date"
        puts "2: Search events by city and name"
        puts "3: View MyEvents"
        puts "9999: Exit"
    end
end
