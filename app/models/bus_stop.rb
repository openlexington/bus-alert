class BusStop < ActiveRecord::Base
  cattr_accessor :cache_length

  self.primary_key = :stop_num

  has_many :bus_arrivals
  belongs_to :bus_route
end
