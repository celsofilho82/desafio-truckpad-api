class Location < ApplicationRecord
  has_many :origin_trips, class_name: 'Trip', foreign_key: 'origin_id'
  has_many :destination_trips, class_name: 'Trip', foreign_key: 'destination_id'
  geocoded_by :full_city_state
  after_validation :geocode
  validates :city, :state, presence: true

  def full_city_state
    [city, state].compact.join(', ')
  end

end
