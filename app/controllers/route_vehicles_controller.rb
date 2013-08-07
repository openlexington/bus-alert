class RouteVehiclesController < ApplicationController
  def index
    if RouteVehicle.where(bus_route_id: params[:bus_route_id]).outdated.exists? || !RouteVehicle.where(bus_route_id: params[:bus_route_id]).exists?
      refresh_vehicles(params[:bus_route_id])
    end
    bus_vehicles = RouteVehicle.for_route(params[:bus_route_id])

    render json: bus_vehicles
  end

  private

  def refresh_vehicles( route_id )
    new_vehicles = Lextran::Vehicle.for_route(route_id)
    if new_vehicles.present?
      RouteVehicle.transaction do
        RouteVehicle.delete_all(bus_route_id: route_id)
        new_vehicles.each do |vehicle|
          RouteVehicle.create!(vehicle.to_h)
        end
      end # RouteVehicle.transaction
    end
  end # refresh_routes
end
