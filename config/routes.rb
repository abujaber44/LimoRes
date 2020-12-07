Rails.application.routes.draw do
  root :to => "pages#home"
  
  get '/signup', to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get '/auth/google_oauth2/callback', to: 'sessions#google_login'

  resources :users do 
    resources :reservations, only: [:new, :create, :show, :index]
    resources :addresses, only: [:new, :create, :show, :index]
    get '/past_reservations', to: 'reservations#past_reservations'
  end

  resources :reservations, only: [:edit, :update, :destroy]

  resources :addresses, only: [:edit, :update, :destroy]

  resources :drivers

  get '/future_reservations',  to: 'pages#future_reservations'
  get '/archived_reservations', to: 'pages#archived_reservations'

  get 'reservations/:id/choose_drivers', to: 'reservations#edit_choose_drivers', as: 'edit_choose_drivers'
  patch 'reservations/:id/choose_drivers', to: 'reservations#update_choose_drivers', as: 'update_choose_drivers'

end






