Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'main#index'

  resources :elevators do
    get :step
  end
  get 'elevators/:id/call_to_floor/:floor', to: 'elevators#call_to_floor'
end
