require_relative '../config/environment'
require 'rest-client'
require 'json'
require 'pry'


Event.delete_all
User.delete_all
EventUser.delete_all
Venue.delete_all

# b = ENV["venue_data"]

# venue_api_data = RestClient.get(b)
# venue_info = JSON.parse(venue_api_data)

# venues = venue_info["_embedded"]["venues"].each do |venue_array|
#     Venue.create(name: venue_array["name"],
#     city: venue_array["city"]["name"],
#     address: venue_array["address"]["line1"])
# end


a = ENV["data"]
ryan_api_key = ENV["ryans_api"]
karan_api_key = ENV["karans_api"]


api_data = RestClient.get(a)
event_data = JSON.parse(api_data)

events = event_data["_embedded"]["events"].select do |event|
    event["_embedded"]["venues"][0]["city"]["name"] == "Flushing"
# event["dates"]["start"]["localDate"] == "2021-09-10" && 
end

names = events.map {|event| event["name"]}

cities = event_data["_embedded"]["events"].map do |event|
    event["_embedded"]["venues"][0]["city"]["name"]
end.uniq

binding.pry

# while event_data

#     event_data = event_data["_links"]["next"]["href"] ? JSON.parse(RestClient.get("https://app.ticketmaster.com" + "#{event_data["_links"]["next"]["href"]}" + "#{karan_api_key}")) : nil
# end

# events = event_data.each do |event_hash|
#     event = Event.create(name: event_hash["name"], 
#     date: event_hash["dates"]["start"]["localDate"],
#     genre: event_hash["classifications"][0]["genre"]["name"],
#     city: event_hash["_embedded"]["venues"][0]["city"]["name"],
#     venue_id: Venue.find_by(name: event_hash["_embedded"]["venues"][0]["name"]).id)
# end



# narrowed_search = event_data["_embedded"]["events"].select do |event_hash|
#     event_hash["_embedded"]["venues"][0]["state"]["name"] == "New York"
# end

# event_by_date = event_data["_embedded"]["events"].select do |event_hash|
#     event_hash["dates"]["start"]["localDate"] == date
# end

# event_by_state = event_data["_embedded"]["events"].select do |event_hash|
#     event_hash["_embedded"]["venues"][0]["state"]["name"] == "New Jersey"
# end

# event_by_city = event_data["_embedded"]["events"].select do |event_hash|
#     event_hash["_embedded"]["venues"][0]["city"]["name"] == "New Jersey"
# end












