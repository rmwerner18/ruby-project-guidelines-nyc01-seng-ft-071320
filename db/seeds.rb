require 'rest-client'
require 'json'
require 'pry'

api_data = RestClient.get("https://app.ticketmaster.com/discovery/v2/events.json?apikey=SsbAwQfGOGoLOyWoKzWrGDhTyUWemYzo")
event_data = JSON.parse(api_data)


event_data["_embedded"]["events"].each do |event_hash|
    event = Event.create(name: event_hash["name"])
end

