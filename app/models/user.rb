class User < ActiveRecord::Base
    has_many :event_users
    has_many :events, through: :event_users
    
    def self.login
        puts "Welcome to our app!"
        puts "What is your first name?"
        first_name = gets.chomp
        puts "what is your last name"
        last_name = gets.chomp
        puts "please create a password"
        password = gets.chomp
        User.create_or_find_by(first_name: first_name, last_name: last_name, password: password)
    end
end