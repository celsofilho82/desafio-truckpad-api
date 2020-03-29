class CreateTrips < ActiveRecord::Migration[5.2]
  def change
    create_table :trips do |t|
      t.references :origin
      t.references :destination
      t.boolean :truck_loaded
      t.boolean :has_load_back
      t.references :driver, foreign_key: true

      t.timestamps
    end
  end
end
