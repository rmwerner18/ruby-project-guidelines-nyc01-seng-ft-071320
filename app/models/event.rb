class Event < ActiveRecord::Base
    belongs_to :venue
    has_many :event_users
    has_many :users, through: :event_users

    def self.find_by_city(city, date)
        event_by_city = Event.all.select do |event|
            (event.city == city) && (event.date.strftime("%F") == date)
        end
    end

    def self.search
        puts "Please specify a city"
            city = gets.chomp
        puts "Please specify a date (yyyy-mm-dd)"
            date = gets.chomp
        event = Event.find_by_city(city, date)
        p event
    end
end