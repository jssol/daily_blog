Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root to: redirect('users')

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create, :destroy]
    resources :comments, only: [:new, :create, :destroy]
    resources :likes, only: [:new, :create]
  end
end
