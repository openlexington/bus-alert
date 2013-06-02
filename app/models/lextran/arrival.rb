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
      endpoint = '/map/GetStopHtml.ashx'
      options = { query: { stopId: stop_id } }
      data = get(endpoint, options)
      unless data.response.code == '200'
        raise ApiError, "Something went wrong retrieving #{endpoint}" +
                        " #{options.inspect}: #{data.response.message}"
      end

      doc = Nokogiri::HTML(data.parsed_response)
      doc = table_for_route(doc, route_id)
      begin
        sdt_col = find_sdt_col(doc.css('tr').first)
        edt_col = find_edt_col(doc.css('tr').first)
      rescue ApiError
        raise ApiError, "Failed to find departure times in HTML:" +
                        " #{data.parsed_response}"
      end

      # Skip the header row.
      rows = doc.css('tr')[1..-1]
      rows.map { |tr|
        ApiResponse.new( stop_id,
                         tr.css('td')[sdt_col].text,
                         tr.css('td')[edt_col].text )
      }
    end

    ############################################################################
    private
    ############################################################################

    def self.table_for_route( doc, route_id )
      doc.css('table').find { |table|
        table.css('td.headingText').text.match(/Route:\w+#{route_id}/)
      }
    end

    def find_sdt_col( tr )
      tr.css('th').each_with_index do |th, i|
        return i if th.attr('class') == 'sdt'
      end
      raise ApiError
    end

    def find_edt_col( tr )
      tr.css('th').each_with_index do |th, i|
        return i if th.attr('class') == 'edt'
      end
      raise ApiError
    end
  end
end
