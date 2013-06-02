# How often should each of these objects be re-fetched from the provider?
begin
  BusRoute.cache_time = 1.day
  BusStop.cache_time = 1.day
  BusArrival.cache_time = 5.seconds
rescue NoMethodError
  Rails.logger.warn 'Failed to set model cache times--has DB been migrated?'
end
