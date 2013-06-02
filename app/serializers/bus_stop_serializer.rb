class BusStopSerializer < ActiveModel::Serializer
  attributes :id, :name, :lat, :long, :route_id, :stop_num
end
