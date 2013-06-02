class BusRoute < ActiveRecord::Base
  cattr_accessor :cache_length

  self.primary_key = :route_num

  has_many :bus_stops
end
