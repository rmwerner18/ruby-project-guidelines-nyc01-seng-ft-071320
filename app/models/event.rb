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

    def self.find_event_by_name_and_date(name, date)
        Event.all.find do |event|
            (event.name == name) && (event.date.strftime("%F") == date)
        end
    end

    # def self.find_event_with_two_parameters(one, two)
    #     is_one_a_city = Event.all.find {|event| event.city == one}
    #     is_two_a_name = Event.all.find {|event| event.name == two}
    #     method_one = is_one_a_city ? event.city : event.name 
    #     method_two = is_two_a_name ? event.name : event.date.strftime("%F")
    #     Event.all.select do |event|
    #         (event.method_one == one) && (event.method_two == two)
    #     end
    # end

    # def self.split_input
    #     one_and_two = gets.chomp
    #     one = one_and_two.split(", ")[0]
    #     two = one_and_two.split(", ")[1]
    #     event = Event.find_by_city_and_date(one, two)
    #     p event
    # end


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