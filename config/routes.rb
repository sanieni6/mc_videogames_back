Rails.application.routes.draw do
  devise_for :users,
              controllers: {
                sessions: 'users/sessions',
                registrations: 'users/registrations'
              }
  get '/member-data', to: 'members#show'


  resources :reservations, only: [:index, :new, :create]
  resources :videogames, only: [:index, :show, :new, :create, :destroy]
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
