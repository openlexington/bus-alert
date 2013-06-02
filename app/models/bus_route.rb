class BusRoute < ActiveRecord::Base
  cattr_accessor :cache_length

  self.primary_key = :route_num
end
