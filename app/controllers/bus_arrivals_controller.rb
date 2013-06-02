class BusArrivalsController < ApplicationController
  def index
    refresh_arrivals(params[:bus_stop_id], params[:bus_route_id])
    bus_arrivals = BusArrival.for_stop(params[:bus_stop_id])

    render json: bus_arrivals
  end

  def next
    refresh_arrivals(params[:bus_stop_id], params[:bus_route_id])
    arrival = BusArrival.for_stop(params[:bus_stop_id]).order(:estimated_at).first

    render json: arrival
  end

  ##############################################################################
  private
  ##############################################################################

  def refresh_arrivals( stop_id, route_id )
    if BusArrival.where(stop_id: stop_id).outdated.exists? || !BusArrival.exists?
      new_arrivals = Lextran::Arrival.for_stop(stop_id, route_id)
      if new_arrivals.present?
        BusArrival.transaction do
          BusArrival.where(stop_id: stop_id).delete_all
          new_arrivals.each do |arrival|
            BusArrival.create!(arrival.to_h)
          end
        end # BusArrival.transaction
      end
    end
  end # refresh_arrivals
end
