class Event < ActiveRecord::Base
    belongs_to :venue
    has_many :event_users
    has_many :users, through: :event_users



    def self.find_by_city(city, date)
        a = ENV["data"]
        api_data = RestClient.get(a)
        event_data = JSON.parse(api_data)
        event_by_city = event_data["_embedded"]["events"].select do |event_hash|
            (event_hash["_embedded"]["venues"][0]["city"]["name"] == city) && (event_hash["dates"]["start"]["localDate"] == date)
        end
        event_by_city.map {|event| event["name"]}
    end

end