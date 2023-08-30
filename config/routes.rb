Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  

  root 'albums#index'
  get 'users/:user_id/albums', to: 'albums#user_albums', as: 'user_albums'

  
  
  resources :albums do
    member do
      delete 'delete_image/:image_id', to: 'albums#delete_image', as: :delete_image
    end
  end
end
