require 'rest-client'
require 'json'
require 'pry'
require 'dotenv/load'

api_data = RestClient.get(api)
event_data = JSON.parse(api_data)


event_data["_embedded"]["events"].each do |event_hash|
    event = Event.create(name: event_hash["name"])
end

