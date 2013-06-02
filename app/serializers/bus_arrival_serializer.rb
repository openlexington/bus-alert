class BusArrivalSerializer < ActiveModel::Serializer
  attributes :id, :bus_id, :bus_stop_id, :scheduled_at, :estimated_at
end
