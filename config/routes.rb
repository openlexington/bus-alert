BusAlert::Application.routes.draw do

  resources :bus_routes,    except: [:new, :edit, :create, :update]

  resources :bus_stops,     except: [:new, :edit, :create, :update]

  resources :bus_arrivals,  except: [:new, :edit, :create, :update] do
    collection do
      get :next
    end
  end

end
