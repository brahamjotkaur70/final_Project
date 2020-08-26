Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
 root to: "products#index"

 get "/products/new" => "products#new", as: :new_product
 post "/products" => "products#create", as: :products
 get "/products/:id" => "products#show", as: :product
 get "/products" => "products#index"
 get "/products/:id/edit" => "products#edit"


 resource :cart, only: [:show] do
  put    :add_item
  delete :remove_item
end
resources  :categories, except: [:edit, :update ]
resources :orders, only: [:index, :create, :show]
resources :line_items, only: [:create, :destroy]


resources :products, only: [:index, :show, :edit, :update, :destroy]

 get("/welcome", to: "welcome#welcome")



  get("/login", to: "sessions#login")
  get("/register", to: "users#register")
  post("/users", to: "users#create")



  post("/login", to: "sessions#create")
  get("/logout", to: "sessions#destroy")


end
