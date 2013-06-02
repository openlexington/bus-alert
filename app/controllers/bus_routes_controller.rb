class BusRoutesController < ApplicationController
  def index
    if BusRoute.outdated.exists? || !BusRoute.exists?
      refresh_routes
    end
    bus_routes = BusRoute.all

    render json: bus_routes
  end

  ##############################################################################
  private
  ##############################################################################

  def refresh_routes
    new_routes = Lextran::Route.all
    if new_routes.present?
      BusRoute.transaction do
        BusRoute.delete_all
        new_routes.each do |route|
          BusRoute.create!(route.to_h)
        end
      end # BusRoute.transaction
    end
  end # refresh_routes
end
