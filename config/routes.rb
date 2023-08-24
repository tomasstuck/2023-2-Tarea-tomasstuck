Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get "/directors/oscars", to: "directors#oscars"                              # 1.6
  get "/directors", to: "directors#index"                                      # 1.1
  post "/directors", to: "directors#create"                                    # 1.2
  get "/director/:id", to: "directors#show"                                    # 1.3
  delete "/director/:id", to: "directors#destroy"                              # 1.4
  delete "/directors", to: "directors#destroy_all"                             # 1.5

  resources :directors do
    resources :movies
  end

  get "/director/:director_id/movies", to: "movies#index"                      # 2.1          
  post "/director/:director_id/movies", to: "movies#create"                    # 2.2
  patch "/director/:director_id/movies/:movie_id", to: "movies#update"         # 2.3
  get "/movies/sinopsis/:keyword", to: "movies#search"                         # 2.4

  resources :directors do
    resources :rankings
  end

  post "/ranking/:director_id", to: "rankings#create"                          # 3.1
  get "/ranking/:director_id", to: "rankings#index"                            # 3.2
  get "/ranking/top/:quantity", to: "rankings#top"                             # 3.3
  get "/movies/:movie_id/director/rankings", to: "rankings#show_from_movie"    # 3.4
  delete "/director/ranking/low", to: "rankings#destroy_low"                   # 3.5
  get "/ranking/pages/all", to: "rankings#show"                                # 3.6
end
