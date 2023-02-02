Rails.application.routes.draw do
  get 'profile/:id', to: 'profiles#index', as: :profile
  get 'show_profile/:id', to: 'profiles#show_profile', as: :show_profile
  devise_for :users
  resources :videos
  root 'pages#home'
end
