class CreateBusArrivals < ActiveRecord::Migration
  def change
    create_table :bus_arrivals do |t|
      t.integer :bus_id
      t.integer :stop_id
      t.datetime :scheduled_at
      t.datetime :estimated_at

      t.timestamps
    end

    add_index :bus_arrivals, :stop_id
  end
end
