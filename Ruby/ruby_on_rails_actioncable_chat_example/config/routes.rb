
Rails.application.routes.draw do
  resources :rooms, only: [:show]
  root "rooms#show"
end
