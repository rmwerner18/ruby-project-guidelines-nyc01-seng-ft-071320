require_relative '../config/environment'
require 'rest-client'
require 'json'
require 'pry'

a = ENV["data"]
binding.pry
api_data = RestClient.get(a)
event_data = JSON.parse(api_data)


event_data["_embedded"]["events"].each do |event_hash|
    event = Event.create(name: event_hash["name"])
end

