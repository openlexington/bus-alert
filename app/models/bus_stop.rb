class BusStop < ActiveRecord::Base
  cattr_accessor :cache_length

  self.primary_key = :stop_num
end
