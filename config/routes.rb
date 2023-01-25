Rails.application.routes.draw do
  devise_for :users
  resources :videos
  root 'pages#home'
end
