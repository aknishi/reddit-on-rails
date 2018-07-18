Rails.application.routes.draw do


  get 'comments/create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
  resource :session
  
  resources :subs, except: [:destroy] do
    resources :posts, only: [:create]
  end
  
  resources :posts, except: [:index, :create] do
    resources :comments, only: [:new, :create]
  end
  
  resources :comments do
    resources :comments, only: [:new, :create]
  end


end
