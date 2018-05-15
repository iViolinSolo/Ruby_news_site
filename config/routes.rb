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
  get    '/item',    to: 'schoolnews#show'

  scope 'v0' do
    scope 'item' do
      get '/comments/:id', to: 'comments#show', defaults: { format: 'json' }
      get '/news/:id', to: 'schoolnews#show', defaults: { format: 'json' }
      post '/create', to: 'schoolnews#create_json', defaults: { format: 'json'}
    end
  end

  resources :users
  resources :schoolnews
  resources :comments

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
