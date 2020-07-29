require 'pry'

class CLI
    def start
        user = User.login_or_create
        if user
            searched_events = user.search_events
            if searched_events
                user.add_from_searched_events?(searched_events)
            end
            user.see_my_events?
            user.exit?            
        else puts "Please enter a valid username/password"
        end
    end
end