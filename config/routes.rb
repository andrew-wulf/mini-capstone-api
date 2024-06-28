Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"


  get "/products" => "products#index"
  post "/products/create" => "products#create"
  get "/products/test/:id" => "products#test"

  get "/products/search/:q" => "products#search"
  get "/products/deals" => "products#deals"
  get "/products/:id" => "products#show"
  
  patch "/products/:id" => "products#update"
  delete "products/:id" => "products#destroy"

  get "/categories" => "categories#index"
  get "/categories/:name" => "categories#show"

  get "/suppliers" => "suppliers#index"
  post "/suppliers/create" => "suppliers#create"

  get "/suppliers/:id" => "suppliers#show"
  patch "/suppliers/:id" => "suppliers#update"
  delete "suppliers/:id" => "suppliers#destroy"

  get "/images" => "images#index"
  post "/images/create" => "images#create"

  get "/images/:id" => "images#show"
  patch "/images/:id" => "images#update"
  delete "images/:id" => "images#destroy"
 
  get "/users" => "users#index"
  get "/users/current" => "users#current_user_info"
  post "/users" => "users#create"
  post "/sessions" => "sessions#create"
  get "/login" => "sessions#login"


  get "/orders" => "orders#index"
  get "orders/:id" => "orders#show"
  post "/orders" => "orders#create"


  post "/cart" => "carted_products#create"
  patch "/cart/:id" => "carted_products#update"
  delete "/cart/:id" => "carted_products#remove"
  post "/cart/checkout" => "carted_products#checkout"


end
