# How often should each of these objects be re-fetched from the provider?
begin
  BusRoute.cache_length   = 1.day
  BusStop.cache_length    = 1.day
  BusArrival.cache_length = 5.seconds
rescue NoMethodError
  Rails.logger.warn 'Failed to set model cache times--has DB been migrated?'
end
