class BusStop < ActiveRecord::Base
  cattr_accessor :cache_length

  self.primary_key = :stop_num

  has_many :bus_arrivals
  belongs_to :bus_route

  def self.outdated
    puts 'cache_length', BusStop.cache_length.inspect
    where( arel_table[:updated_at].lt(Time.now - BusStop.cache_length) )
  end

  def self.for_route( route_id )
    where(bus_route_id: route_id)
  end
end
