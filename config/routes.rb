Rails.application.routes.draw do
  root 'welcome#index'
  get '/register', to: 'users#new'
  get '/users/:id/movies', to: 'movies#index', as: 'movies'
  get '/users/:user_id/movies/:id', to: 'movies#show', as: 'movie'

  resources :users, only: [:show, :create]
  # get "/login", to: "users#login_form" 
  # get "/login", to: "sessions#new" 

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  namespace :admin do
    get "/dashboard", to: "dashboard#index"
  end


  get '/users/:user_id/movies/:movie_id/viewing_parties/new', to: 'viewing_parties#new'
  post '/users/:user_id/movies/:movie_id/viewing_parties', to: 'viewing_parties#create'
end
