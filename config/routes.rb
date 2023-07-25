Rails.application.routes.draw do  
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  
  devise_for :users,
              controllers: {
                sessions: 'users/sessions',
                registrations: 'users/registrations'
              }
  get '/member-data', to: 'members#show'

  resources :reservations, only: [:index, :new, :create, :show]
  resources :videogames, only: [:index, :show, :new, :create, :destroy]
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: redirect('/api-docs')

end
