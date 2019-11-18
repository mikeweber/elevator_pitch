Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'main#index'

  resources :elevators do
    post :step, on: :collection
    post :step, on: :member
  end
  post 'elevators/call_to_floor/:floor', to: 'elevators#call_to_floor'
  post 'elevators/:id/send_to_floor/:floor', to: 'elevators#send_to_floor'

  mount ActionCable.server, at: '/cable'
end
