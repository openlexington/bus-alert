module Lextran
  class Vehicle
    include HTTParty
    base_uri 'http://realtime.lextran.com'
    # NOTE: Referrer spoofing not actually needed for 'GetRouteXml.ashx' endpoint.
    headers 'referer' => 'http://realtime.lextran.com/InfoPoint/'

    class APIError < StandardError; end

    class APIResponse < Struct.new(:bus_number, :lat, :long, :bus_route_id)
    end

    def self.for_route( route_id )
      endpoint = '/InfoPoint/map/GetVehicleXml.ashx'
      options = { query: { RouteId: route_id } }
      data = get(endpoint, options)
      unless data.response.code == '200'
        raise ApiError, "Something went wrong retrieving #{endpoint}" +
                        " #{options.inspect}: #{data.response.message}"
      end

      puts "route_id #{route_id}"

      # At times a route might not have any vehicles
      data = data['vehicles'] || {'vehicle' => []}

      # At times a route only has a single vehicle
      data['vehicle'] = Array.wrap(data['vehicle'])

      data['vehicle'].map { |vehicle|
        APIResponse.new( vehicle['name'],
                         vehicle['lat'],
                         vehicle['lng'],
                         route_id )
      }
    end
  end
end
