Rails.application.routes.draw do

  root 'pages#home'
  
  get '/home', to: 'pages#home'
  
  resources :photos do
    member do
      post 'like'
    end
    resources :comments
  end
  

  resources :users, except: [:new, :destroy]

  get '/register', to: 'users#new'
  
  get '/login', to: 'logins#new'
  post '/login', to: 'logins#create'
  get '/logout', to: 'logins#destroy'
  
  resources :tags, only: [:new, :create, :show]
    
end
