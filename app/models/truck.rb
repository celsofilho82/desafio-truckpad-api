class Truck < ApplicationRecord
  has_many :drivers
  has_many :trips
end
