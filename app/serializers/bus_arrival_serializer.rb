class BusArrivalSerializer < ActiveModel::Serializer
  attributes :id, :bus_no, :stop_id, :scheduled_at, :estimated_at
end
