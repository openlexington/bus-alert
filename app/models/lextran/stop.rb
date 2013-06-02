module Lextran
  class Stop
    include HTTParty
    base_uri 'http://realtime.lextran.com'
    # NOTE: Referrer spoofing not actually needed for 'GetRouteXml.ashx' endpoint.
    headers 'referer' => 'http://realtime.lextran.com/InfoPoint/'

    class APIError < StandardError; end

    class APIResponse < Struct.new(:name, :lat, :long, :stop_num, :bus_route_id)
    end

    def self.for_route( route_id )
      endpoint = '/InfoPoint/map/GetRouteXml.ashx'
      options = { query: { RouteId: route_id } }
      data = get(endpoint, options)
      unless data.response.code == '200'
        raise ApiError, "Something went wrong retrieving #{endpoint}" +
                        " #{options.inspect}: #{data.response.message}"
      end

      puts 'route_id', route_id
      data = data['route']
      data = data['stops']
      data['stop'].map { |stop|
        APIResponse.new( stop['label'],
                         stop['lat'],
                         stop['lng'],
                         stop['html'],
                         route_id )
      }
    end
  end
end
