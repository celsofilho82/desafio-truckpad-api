class AddAgeToDrivers < ActiveRecord::Migration[5.2]
  def change
    add_column :drivers, :birthdate, :string
  end
end
