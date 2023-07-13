Rails.application.routes.draw do
  devise_for :users,
              controllers: {
                sessions: 'users/sessions',
                registrations: 'users/registrations'
              }
get '/member-data', to: 'members#show'

  resources :users, only: [] do
    get '/videogames', to: 'videogames#index'
    resources :reservations, only: [:index, :new, :create, :destroy] do
      resources :videogames, only: [:index, :new, :create, :destroy]
    end
  end

  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
