class AddTruckRefToTrips < ActiveRecord::Migration[5.2]
  def change
    add_reference :trips, :truck, foreign_key: true
  end
end
