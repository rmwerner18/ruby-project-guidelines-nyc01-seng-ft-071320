class Event < ActiveRecord::Base
    belongs_to :venue
    has_many :event_users
    has_many :users, through: :event_users



    def self.find_by_city(city, date)
        # a = ENV["data"]
        # api_data = RestClient.get(a)
        # event_data = JSON.parse(api_data)
        event_by_city = Event.all.select do |event|
            (event.city == city) && (event.date.strftime("%F") == date)
        end

    end

    def self.search
        puts "Please specify a city"
            city = gets.chomp
        puts "Please sepcify a date (yyyy-mm-dd)"
            date = gets.chomp
        Event.find_by_city(city, date)
    end

end