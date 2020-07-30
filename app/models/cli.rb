require 'pry'
require "pp"

class CLI

    def main_functions(user)
        User.show_choices
        choice = gets.chomp
        if choice == "1"
            searched_events = Event.search_by_city_and_date
            if searched_events.any?
                user.add_from_searched_events?(searched_events)
            else puts "Could not find an event on that date in that city"
            end
            self.main_functions(user)           
        elsif choice == "2"
            searched_events = Event.search_by_city_and_name
            PP.pp(searched_events)
            if searched_events.any?
                puts "Would you like to add any of these events to MyEvents? (yes/no)"
                response = gets.chomp
                if response == "yes"
                    puts "Select the date of the event you would like to add (yyyy-mm-dd)"
                    chosen_date = gets.chomp
                    chosen_event = searched_events.find {|event| event.date.strftime("%F") == chosen_date}
                    user.add_to_my_events(chosen_event)
                    puts "The event has been added!"
                end
            else puts "Could not find any events in that city with that name"
            end
            self.main_functions(user)
        elsif choice == "3"
            puts "What is the name of the venue you would like to search?"
            venue_name = gets.chomp
            venue = Venue.all.find {|venue| venue.name == venue_name}
            if venue
                p PP.pp(venue.events)
                puts "Would you like to add any of these events to MyEvents? (yes/no)"
                response = gets.chomp
                if response == "yes"
                    puts "Select the date of the event you would like to add (yyyy-mm-dd)"
                    chosen_date = gets.chomp
                    chosen_event = venue.events.find {|event| event.date.strftime("%F") == chosen_date}
                    user.add_to_my_events(chosen_event)
                    puts "The event has been added!"
                end
            else puts "Could not find that venue"
            end
            self.main_functions(user)
        elsif choice == "4"
            names_and_dates = user.events.map {|event| "#{event.name}, #{event.date}"}
            p PP.pp(names_and_dates)
            if user.events.any?
                puts "Would you like to see more information for any of these events? (yes/no)"
                response = gets.chomp
                if response == "yes"
                    puts "Please enter the name and date of the event (name, yyyy-mm-dd)"
                    name_and_date = gets.chomp
                    name = name_and_date.split(", ")[0]
                    date = name_and_date.split(", ")[1]
                    event = user.find_event_by_name_and_date(name, date)
                    venue = Venue.all.find {|venue| venue.id == event.venue_id}
                    p event
                    p venue
                end
                puts "Would you like to delete any events from MyEvents? (yes/no)"
                response = gets.chomp
                if response == "yes"
                    user.delete_event_by_name_and_date
                    if user.events.any?
                        puts "Would you like to delete any other events? (yes/no)"
                        response = gets.chomp
                        if response == "yes"
                            user.delete_event_by_name_and_date
                        end
                    end
                end
            else puts "You have no events"
            end
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