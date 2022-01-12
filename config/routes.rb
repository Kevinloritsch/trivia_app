Rails.application.routes.draw do
  root 'static_pages#home'
  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/create', to: 'trivia_form#create'
  post'/submit', to: 'trivia_form#submit'
  get '/play', to: 'static_pages#play'
  get '/play/:gamesession', to: 'trivia_games#clients', as: 'clients_play_trivia_game'
  get '/users/:user_id/trivia_game/:id/host/:gamesession', to: 'trivia_games#host', as: 'host_user_trivia_game'
  resources :users do
    resources :trivia_games
  end
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
end
  