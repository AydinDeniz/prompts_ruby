
Rails.application.routes.draw do
  resources :products, only: [:index]
  get 'orders/recent', to: 'orders#recent_orders'
end
