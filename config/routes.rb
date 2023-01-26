Rails.application.routes.draw do
  get 'profile/:id', to: 'profiles#index', as: :profile
  devise_for :users
  resources :videos
  root 'pages#home'
end
