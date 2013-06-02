class BusArrival < ActiveRecord::Base
  cattr_accessor :cache_length

  belongs_to :bus_stop
end
