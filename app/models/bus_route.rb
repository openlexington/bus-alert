class BusRoute < ActiveRecord::Base
  cattr_accessor :cache_length

  self.primary_key = :route_num

  has_many :bus_stops

  def self.outdated
    where( arel_table[:updated_at].lt(Time.now - BusRoute.cache_length) )
  end
end
