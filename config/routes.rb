Rails.application.routes.draw do

  get 'pages/timeline'

  resources :categories

  devise_for :users
  #, :skip => :registrations
  #get 'users/:id' => 'users#show', as: 'user'
  #get 'users/index'
  resources :users, :only => [:show,:index]

  resources :posts

  get 'welcome/index'
  root 'welcome#index'

  get 'pages/timeline'

  get '*path' => redirect('/')
end
