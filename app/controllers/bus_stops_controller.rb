class BusStopsController < ApplicationController
  def index
    if BusStop.where(route_id: params[:bus_route_id]).outdated.exists? || !BusStop.exists?
      refresh_stops(params[:bus_route_id])
    end
    bus_stops = BusStop.for_route(params[:bus_route_id])

    render json: bus_stops
  end

  ##############################################################################
  private
  ##############################################################################

  def refresh_stops( route_id )
    new_stops = Lextran::Stop.for_route(route_id).uniq(&:stop_num)
    if new_stops.present?
      BusStop.transaction do
        BusStop.where(route_id: route_id).delete_all
        new_stops.each do |stop|
          BusStop.create!(stop.to_h)
        end
      end # BusStop.transaction
    end
  end # refresh_stops
end
