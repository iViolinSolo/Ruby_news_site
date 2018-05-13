Rails.application.routes.draw do
  get 'schoolnews/new'

  root   'schoolnews#index'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get    '/signup',  to: 'users#new'
  get    'users/show'
  get    'static_pages/home'
  get    'static_pages/help'
  get    'static_pages/about'
  get    '/news',    to: 'schoolnews#index'
  get    '/news?p=0',to: 'schoolnews#index'
  get    '/submit',  to: 'schoolnews#new'
  get    '/newcomments',to: 'comments#newcomments'

  resources :users
  resources :schoolnews
  resources :comments
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
