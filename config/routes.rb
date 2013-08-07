BusAlert::Application.routes.draw do

  resources :bus_routes, only: [:index] do
    resources :route_vehicles, only: [:index]

    resources :bus_stops, only: [:index] do
      resources :bus_arrivals,  only: [:index] do
        collection do
          get :next
        end
      end # arrivals
    end # stops
  end # routes

end
