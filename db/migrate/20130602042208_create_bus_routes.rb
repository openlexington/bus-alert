class CreateBusRoutes < ActiveRecord::Migration
  def change
    create_table :bus_routes, id: false do |t|
      t.string :name
      t.integer :route_num

      t.timestamps
    end

    add_index :bus_routes, :route_num
  end
end
