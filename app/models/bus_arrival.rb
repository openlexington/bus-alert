class BusArrival < ActiveRecord::Base
  cattr_accessor :cache_length

  belongs_to :bus_stop

  def self.outdated
    where( arel_table[:updated_at].lt(Time.now - BusArrival.cache_length) )
  end

  def self.for_stop( stop_id )
    where(bus_stop_id: stop_id)
  end
end
