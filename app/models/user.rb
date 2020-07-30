require "pp"

class User < ActiveRecord::Base
    has_many :event_users
    has_many :events, through: :event_users



    def self.login_or_create
        puts "Would you like to sign up or log in?"
        action = gets.chomp
        puts "What is your first name?"
        first_name = gets.chomp
        puts "What is your last name?"
        last_name = gets.chomp
        puts "What is your password"
        password = gets.chomp
        if action == "sign up"
            account = User.find_by(first_name: first_name, last_name: last_name, password: password)
            if account
                puts "This account already exists, please login"
                User.login_or_create
            else 
                user = User.create(first_name: first_name, last_name: last_name, password: password)
            end
        elsif action == "log in"
            user = User.find_by(first_name: first_name, last_name: last_name, password: password)
            if user == nil
                puts "Sorry, we didn't find an account with that name and password"
                puts "Please log in again, or create a new account"
                User.login_or_create
            elsif user
                user
            end
        else puts "please specify sign up or log in"
            self.login_or_create
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

    def find_event_by_name_and_date(name, date)
        self.events.all.find do |event|
            (event.name == name) && (event.date.strftime("%F") == date)
        end
    end

    def delete_event_by_name_and_date
        puts "Enter the name and date of the event you would like to delete (name, yyyy-mm-dd)"
        name_and_date = gets.chomp
        name = name_and_date.split(", ")[0]
        date = name_and_date.split(", ")[1]
        event_to_delete = self.find_event_by_name_and_date(name, date)
        if event_to_delete 
            self.events.delete(event_to_delete)
            puts "#{event_to_delete.name}, #{event_to_delete.date} has been deleted!"
        else puts "Could not find an event with that name and date"
            User.choice_4_options
        end
    end

    # def exit?
    #     puts "Would you like to exit? (yes/no)"
    #     response = gets.chomp
    #     if response == "yes"
    #         puts "Thank you, come again!"
    #     elsif response == "no"
    #         puts 'too bad'
    #     end
    # end

    def self.show_choices
        puts "What would you like to do? (enter number)"
        puts "1: Search events by city and date"
        puts "2: Search events by city and name"
        puts "3: Search events by venue"
        puts "4: View MyEvents"
        puts "9999: Exit"
    end

    def self.choice_4_options
        puts "Your events are listed above"
        puts "Please select one of the following actions"
        puts "1: View more information about an event"
        puts "2: Remove an event"
        puts "3: Back to main menu"
    end

    def self.turn_into_hash(venue, event)
        hash = {
            event: {name: event.name,
                        genre: event.genre,
                        date: event.date},
            venue: {name: venue.name,
                city: venue.city,
                address: venue.address}
        }
    end

    def self.choice_4_main_functions(user)
        puts "MyEvents:"
        names_and_dates = user.events.map {|event| "#{event.name}, #{event.date}"}
        p PP.pp(names_and_dates)
        if user.events.any?
            User.choice_4_options
            response = gets.chomp
            if response == "1"
                puts "Please enter the name and date of the event (name, yyyy-mm-dd)"
                name_and_date = gets.chomp
                name = name_and_date.split(", ")[0]
                date = name_and_date.split(", ")[1]
                event = user.find_event_by_name_and_date(name, date)
                if event
                    venue = Venue.all.find {|venue| venue.id == event.venue_id}
                    info_hash = User.turn_into_hash(venue, event)
                    p PP.pp(info_hash)
                    User.choice_4_main_functions(user)                    
                else puts "Could not find an event with that name on that date"
                    User.choice_4_main_functions(user)
                end          
            elsif response == "2"
                user.delete_event_by_name_and_date                  
                if user.events.any?
                    User.choice_4_main_functions(user)
                end
            elsif response == "3"
            end
        else puts "You have no events"
        end
    end

    def self.choice_3_add_event?(venue, user)
        puts "Would you like to add any of these events to MyEvents? (yes/no)"
        response = gets.chomp
        if response == "yes"
            puts "Select the date of the event you would like to add (yyyy-mm-dd)"
            chosen_date = gets.chomp
            chosen_event = venue.events.find {|event| event.date.strftime("%F") == chosen_date}
            user.add_to_my_events(chosen_event)
            puts "The event has been added!"
        elsif response == "no"
            CLI.main_functions(user)
        else puts "Please enter a valid response"
            User.choice_3_add_event?(user)
        end 
    end

    def self.choice_3_main_functions(user)
        puts "What is the name of the venue you would like to search?"
        venue_name = gets.chomp
        venue = Venue.all.find {|venue| venue.name == venue_name}
        if venue
            p PP.pp(venue.events)
            User.choice_3_add_event?(venue, user)
        else puts "Could not find that venue"
        end
    end

    def self.choice_2_add_event?(searched_events, user)
        puts "Would you like to add any of these events to MyEvents? (yes/no)"
        response = gets.chomp
        if response == "yes"
            puts "Select the date of the event you would like to add (yyyy-mm-dd)"
            chosen_date = gets.chomp
            chosen_event = searched_events.find {|event| event.date.strftime("%F") == chosen_date}
            user.add_to_my_events(chosen_event)
            puts "The event has been added!"
        elsif response == "no" 
            CLI.main_functions(user)
        else puts "Please enter a valid response"            
            User.choice_2_add_event?(searched_events, user)           
        end
    end
     
    def self.choice_2_main_functions(user)
        searched_events = Event.search_by_city_and_name
        PP.pp(searched_events)
        if searched_events.any?
            self.choice_2_add_event?(searched_events, user)
        else puts "Could not find any events in that city with that name"
        end
    end

    def self.choice_1_main_functions(user)
        searched_events = Event.search_by_city_and_date
        PP.pp(searched_events)
        if searched_events.any?
            puts "Would you like to add any of these events to MyEvents? (yes/no)"
            response = gets.chomp
            if response == "yes"
                puts "Select the name of the event you would like to add"
                chosen_name = gets.chomp
                chosen_event = searched_events.find {|event| event.name == chosen_name}
                user.add_to_my_events(chosen_event)
                puts "The event has been added!"
            end
        else puts "Could not find an event on that date in that city"
        end
    end
end
