class BusStopSerializer < ActiveModel::Serializer
  attributes :id, :name, :lat, :long, :bus_route_id
end
