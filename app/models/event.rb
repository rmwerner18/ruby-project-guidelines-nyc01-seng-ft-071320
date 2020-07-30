class Event < ActiveRecord::Base
    belongs_to :venue
    has_many :event_users
    has_many :users, through: :event_users

    def self.find_by_city_and_date(city, date)
        event_by_city = Event.all.select do |event|
            (event.city == city) && (event.date.strftime("%F") == date)
        end
    end

    def self.find_by_city_and_name(city, name)
        event_by_city = Event.all.select do |event|
            (event.city == city) && (event.name == name)
        end
    end

    def self.search_by_city_and_date
        puts "Please specify a city and a date (city, yyyy-mm-dd)"
        city_and_date = gets.chomp
        city = city_and_date.split(", ")[0]
        date = city_and_date.split(", ")[1]
        event = Event.find_by_city_and_date(city, date)
        p event
    end

    def self.search_by_city_and_name
        puts "Please specify a city and a name (city, name)"
        city_and_name = gets.chomp
        city = city_and_name.split(", ")[0]
        name = city_and_name.split(", ")[1]
        event = Event.find_by_city_and_name(city, name)
        p event
    end


end