class Location < ApplicationRecord
  has_many :origin_trips, class_name: 'Trip', foreign_key: 'origin_id'
  has_many :destination_trips, class_name: 'Trip', foreign_key: 'destination_id'
end
