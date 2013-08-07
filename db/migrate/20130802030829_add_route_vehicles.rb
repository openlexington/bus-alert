class AddRouteVehicles < ActiveRecord::Migration
  def change
    create_table :route_vehicles, id: false do |t|
      t.string :bus_number
      t.decimal :lat
      t.decimal :long
      t.integer :bus_route_id

      t.timestamps
    end

    add_index :route_vehicles, :bus_number
    add_index :route_vehicles, :bus_route_id
  end
end
