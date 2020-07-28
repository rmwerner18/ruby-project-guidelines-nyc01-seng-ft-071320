require_relative '../config/environment'
require 'rest-client'
require 'json'
require 'pry'


Event.delete_all
User.delete_all
EventUser.delete_all
Venue.delete_all

b = ENV["venue_data"]

venue_api_data = RestClient.get(b)
venue_info = JSON.parse(venue_api_data)

venue_narrowed_search = venue_info["_embedded"]["venues"].each do |venue_array|
    Venue.create(name: venue_array["name"],
                city: venue_array["city"]["name"],
                address: venue_array["address"]["line1"])
end





a = ENV["data"]

api_data = RestClient.get(a)
event_data = JSON.parse(api_data)

narrowed_search = event_data["_embedded"]["events"].select do |event_hash|
    (event_hash["_embedded"]["venues"][0]["city"]["name"] == "Flushing") 
end

narrowed_search.each do |event_hash|
    event = Event.create(name: event_hash["name"], 
        date: event_hash["dates"]["start"]["localDate"],
        genre: event_hash["classifications"][0]["genre"]["name"],
        city: event_hash["_embedded"]["venues"][0]["city"]["name"],
        venue_id: Venue.find_by(name: event_hash["_embedded"]["venues"][0]["name"]).id)
    end

    # venue_id: ... name: event_hash["_embedded"]["venues"]["name"]).id

# event_by_date = event_data["_embedded"]["events"].select do |event_hash|
#     event_hash["dates"]["start"]["localDate"] == date
# end

event_by_state = event_data["_embedded"]["events"].select do |event_hash|
    event_hash["_embedded"]["venues"][0]["state"]["name"] == "New Jersey"
end

# event_by_city = event_data["_embedded"]["events"].select do |event_hash|
#     event_hash["_embedded"]["venues"][0]["city"]["name"] == "New Jersey"
# end

# names_by_date = event_by_date.map do |hash|
#     [
#         hash["name"], 
#         hash["type"],
#         hash["url"],
#         hash["priceRanges"][0]["min"]
# ]
# end


names_by_state = event_by_state.map do |hash|
    [
        hash["name"], 
        hash["type"],
        hash["url"],
        hash["priceRanges"][0]["min"]
    ]
end

# binding.pry
# "something"

################################################################################








