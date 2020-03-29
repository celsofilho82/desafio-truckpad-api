class Driver < ApplicationRecord
  belongs_to :truck, optional: true
  has_many :trips
  validates :name, :cnh_type, presence: true
end
