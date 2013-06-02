module Lextran
  class Route
    include HTTParty
    base_uri 'http://realtime.lextran.com'
    # NOTE: Referrer spoofing not actually needed for 'noscript.aspx' endpoint.
    headers 'referer' => 'http://realtime.lextran.com/InfoPoint/'

    class ApiError < StandardError; end

    class ApiResponse < Struct.new(:name, :route_num)
    end

    def self.all
      endpoint = '/InfoPoint/noscript.aspx'
      data = get(endpoint)
      unless data.response.code == '200'
        raise ApiError, "Something went wrong retrieving #{endpoint}:" +
                        " #{data.response.message}"
      end

      doc = Nokogiri::HTML(data.parsed_response)
      doc.css('a.routeNameListEntry').map { |entry|
        ApiResponse.new( entry.text,
                         entry.attr(:routeid) )
      }
    end
  end
end
