Rails.application.routes.draw do 
  get 'welcome/index'

  resources :articles
  post '/articles/new' => 'articles#create'

  get 'register', to: 'users#new'
  resources :users, expect: [:new]
  
  get 'signin', to: 'sessions#new'
  post 'signin', to: 'sessions#create'
  delete 'signout', to: 'sessions#delete'

  resources :categories

  root 'welcome#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
