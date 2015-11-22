Rails.application.routes.draw do
  devise_for :users
  #, :skip => :registrations
  resources :posts
  get 'welcome/index'
  root 'welcome#index'

  get '*path' => redirect('/')
end
