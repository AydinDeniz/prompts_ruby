
Rails.application.routes.draw do
  post 'auth/login', to: 'auth#login'
  resources :books
end
