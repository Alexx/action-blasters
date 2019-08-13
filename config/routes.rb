Rails.application.routes.draw do
  get '/games' => 'games#index'
  get '/enemies' => 'enemies#create'
  devise_for :users
  root to: 'games#index'
  resources :games do
    resources :locations
    resources :players
  end
  # resources :users do
  # end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
