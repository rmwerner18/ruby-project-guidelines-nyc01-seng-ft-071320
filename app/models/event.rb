class Event < ActiveRecord::Base
    belongs_to :venue
    has_many :event_users
    has_many :users, through: :event_users

    def find_by_city(city)
        event_by_city = event_data["_embedded"]["events"].select do |event_hash|
            event_hash["_embedded"]["venues"][0]["city"]["name"] == city
        end
    end
end