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

  get "/products/:id" => "products#show"
  patch "/products/:id" => "products#update"
  delete "products/:id" => "products#destroy"

  get "/products/categories/:category" => "products#show_category"
  
 

end
