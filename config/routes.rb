BusAlert::Application.routes.draw do

  resources :bus_routes,    only: [:index]

  resources :bus_stops,     only: [:index]

  resources :bus_arrivals,  only: [:index] do
    collection do
      get :next
    end
  end

end
