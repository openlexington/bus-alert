class RouteVehicleSerializer < ActiveModel::Serializer
  attributes :id, :lat, :long, :bus_route_id
end
