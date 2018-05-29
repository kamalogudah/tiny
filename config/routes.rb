Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :links
  get ':code', to: 'links#go_to'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
