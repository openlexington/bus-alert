class BusArrivalSerializer < ActiveModel::Serializer
  attributes :id, :bus_id, :stop_id, :scheduled_at, :estimated_at
end
