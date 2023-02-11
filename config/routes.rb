Rails.application.routes.draw do
  get '/moon', to: 'application#moon', as: 'moon'
  get '/sun', to: 'application#sun', as: 'sun'
  get 'profile/:id', to: 'profiles#index', as: :profile
  get 'show_profile/:id', to: 'profiles#show_profile', as: :show_profile
  get 'activity/:id', to: 'profiles#activity', as: :activity
  devise_for :users
  
  
  resources :videos do
    member do
      patch "upvote", to: "videos#upvote"
      patch "downvote", to: "videos#downvote"
    end
  end

  root 'pages#home'
end
