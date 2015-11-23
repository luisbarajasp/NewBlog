Rails.application.routes.draw do

  devise_for :users
  #, :skip => :registrations
  #get 'users/:id' => 'users#show', as: 'user'
  #get 'users/index'
  resources :users, :only => [:show,:index]

  resources :posts
  get 'welcome/index'
  root 'welcome#index'

  get '*path' => redirect('/')
end
