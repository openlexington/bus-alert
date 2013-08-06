class RouteVehicle < ActiveRecord::Base
  cattr_accessor :cache_length

  self.primary_key = :bus_number

  belongs_to :bus_route

  def self.outdated
    where( arel_table[:updated_at].lt(Time.now - RouteVehicle.cache_length) )
  end

  def self.for_route( route_id )
    where(bus_route_id: route_id)
  end
end
