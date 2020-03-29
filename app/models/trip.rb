class Trip < ApplicationRecord
  belongs_to :driver, optional: true
  belongs_to :origin, class_name: 'Location'
  belongs_to :destination, class_name: 'Location'
  validates :truck_loaded, :has_load_back, presence: true
end
