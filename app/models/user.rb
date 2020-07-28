class User < ActiveRecord::Base
    has_many :event_users
    has_many :events, through: :event_users
    
    # def self.login_logic
    #     puts "What is your first name?"
    #     first_name = gets.chomp
    #     puts "what is your last name"
    #     last_name = gets.chomp
    #     puts "What is your password"
    #     password = gets.chomp
    #     (first_name: first_name, last_name: last_name, password: password)
    # end

    def self.sign_up
        puts "What is your first name?"
        first_name = gets.chomp
        puts "what is your last name"
        last_name = gets.chomp
        puts "What is your password"
        password = gets.chomp
        User.create(first_name: first_name, last_name: last_name, password: password)    
    end
    def self.login
        puts "What is your first?"
        first_name = gets.chomp
        puts "what is your last"
        last_name = gets.chomp
        puts "What is your password"
        password = gets.chomp
        User.find_by(first_name: first_name, last_name: last_name, password: password)
    end

    def add_to_my_events(event)
        EventUser.create(user: self, event: event)
    end

    def add_from_searched_events(event)
        p event
        puts "Would you like to add this event to MyEvents? (yes/no)"
        answer = gets.chomp
        if answer == "yes"
            self.add_to_my_events(event)
        # elsif answer != "yes" && answer != "no"
        #     puts "Please enter a valid response"
        #     user.add_from_searched_events(event)
        end
    end
end
