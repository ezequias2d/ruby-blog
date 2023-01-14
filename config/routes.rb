Rails.application.routes.draw do
  resources :users
  get 'welcome/index'

  resources :articles
  post '/articles/new' => 'articles#create'

  root 'welcome#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
