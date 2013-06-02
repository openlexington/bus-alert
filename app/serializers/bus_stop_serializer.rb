class BusStopSerializer < ActiveModel::Serializer
  attributes :id, :name, :lat, :long, :route_id
end
