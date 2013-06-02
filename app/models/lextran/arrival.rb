module Lextran
  class Arrival
    include HTTParty
    base_uri 'http://realtime.lextran.com/InfoPoint'
    # FIXME: 'GetStopHtml.ashx' endpoint wants referrer AND session ID cookie.
    #  Probably uses session to determine selected route. Crashes if you haven't
    #  picked a route through the front end. Probably not safe to use.
    headers 'referer' => 'http://realtime.lextran.com/InfoPoint/'

    class ApiError < StandardError; end

    class ApiResponse < Struct.new(:stop_id, :scheduled_at, :estimated_at)
    end

    def self.for_stop( stop_id, route_id )
      endpoint = '/departures.aspx'
      options = { query: { stopid: stop_id } }
      data = get(endpoint, options)
      unless data.response.code == '200'
        raise ApiError, "Something went wrong retrieving #{endpoint}" +
                        " #{options.inspect}: #{data.response.message}"
      end

      doc = Nokogiri::HTML(data.parsed_response)

      extract_arrivals(doc, stop_id, route_id)
    end


    ############################################################################
    private
    ############################################################################

    def self.extract_arrivals( doc, stop_id, route_id )
      is_relevant = false
      arrivals = []
      route = BusRoute.find(route_id)

      # Body contains an unorganized list of divs. One div will have the route
      # name, like "Hamburg Pavilion - Outbound", and the following divs have
      # departure times, as '01:22 PM'. When no buses are running, departure
      # time divs will say "Done".
      puts route.name
      doc.css('body div').each do |div|
        puts div.text

        case div.attr('class')
          when 'routeName'
            is_relevant = !!div.text.match(/^#{route.name}/)
          when 'departure'
            if is_relevant
              begin
                # TOTALLY DOES NOT WORK WITH TIME ZONES.
                arrival_at = Time.parse(div.text)
                arrivals << ApiResponse.new(stop_id, arrival_at, arrival_at)
              rescue ArgumentError
                # Non-time info in departure. Usually when buses aren't running.
              end
            end
        end
      end

      arrivals
    end
  end
end
