require_relative '../config/environment'
require 'rest-client'
require 'json'
require 'pry'


Event.delete_all
User.delete_all
EventUser.delete_all
Venue.delete_all

ryan_api_key = ENV["ryans_api"]
karan_api_key = ENV["karans_api"]

b = ENV["venue_data"]
venue_api_data = RestClient.get(b)
venue_info = JSON.parse(venue_api_data)

count = 0 
while Venue.all.length < 900 do
    venue_info["_embedded"]["venues"].each do |venue_array|
        Venue.create(name: venue_array["name"],
        city: venue_array["city"]["name"],
        address: venue_array["address"]["line1"])
    end
    venue_info = JSON.parse(RestClient.get("https://app.ticketmaster.com/discovery/v2/venues?&locale=*&stateCode=NY&page=#{count}" + "#{karan_api_key}"))
    count += 1
end


a = ENV["data"]
api_data = RestClient.get(a)
event_data = JSON.parse(api_data)

count = 0 
while Event.all.length < 900 do
    event_data["_embedded"]["events"].each do |event|
    Event.create(name: event["name"],
        date: event["dates"]["start"]["localDate"],
        genre: event["classifications"][0]["genre"]["name"],
        city: event["_embedded"]["venues"][0]["city"]["name"],
        venue: Venue.find_by(name: event["_embedded"]["venues"][0]["name"]))
    end
    event_data = JSON.parse(RestClient.get("https://app.ticketmaster.com/discovery/v2/events?keyword=%22Music%22&locale=*&startDateTime=2020-08-01T00:00:00Z&endDateTime=2020-12-31T00:00:00Z&countryCode=US&stateCode=NY&page=#{count}" + "#{karan_api_key}"))
    count += 1
end















