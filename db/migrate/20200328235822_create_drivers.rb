class CreateDrivers < ActiveRecord::Migration[5.2]
  def change
    create_table :drivers do |t|
      t.string :name
      t.string :gender
      t.boolean :has_truck
      t.string :cnh_type
      t.references :truck, foreign_key: true

      t.timestamps
    end
  end
end
