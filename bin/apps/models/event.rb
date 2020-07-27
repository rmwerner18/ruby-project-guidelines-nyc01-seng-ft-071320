class Event < ActiveRecord::Base
    belongs_to :venue
    has_many :user_events
    has_many :users, through: :user_events
end