require_relative '../config/environment'
require 'rest-client'
require 'json'
require 'pry'

a = ENV["data"]

api_data = RestClient.get(a)
event_data = JSON.parse(api_data)


event_data["_embedded"]["events"].each do |event_hash|
    event = Event.create(name: event_hash["name"])
end

event_by_date = event_data["_embedded"]["events"].select do |event_hash|
    event_hash["dates"]["start"]["localDate"] == "2021-10-23"
end

event_by_state = event_data["_embedded"]["events"].select do |event_hash|
    event_hash["_embedded"]["venues"][0]["state"]["name"] == "New Jersey"
end

names_by_date = event_by_date.map do |hash|
    [
        hash["name"], 
        hash["type"],
        hash["url"],
        hash["priceRanges"][0]["min"]
]
end

names_by_state = event_by_state.map do |hash|
    [
        hash["name"], 
        hash["type"],
        hash["url"],
        hash["priceRanges"][0]["min"]
    ]
end

binding.pry
"something"





