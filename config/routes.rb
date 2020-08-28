Rails.application.routes.draw do
  root to: 'toppages#index'
 
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'   
  } 

  devise_scope :user do
    get "sign_in", to: 'users/sessions#new'
    get "sign_out", to: 'users/sessions#destroy'
  end

  get "users/:id" => "users#show", as: :mypage
  
  resources :users, only: %i[show edit new update create] do
    member do
      get :likes
    end
  end
  
  resources :likes, only: %i[create destroy]
  resources :posts, only: %i[new show edit update destroy create] 
  
  get '*not_found', to: 'application#routing_error'
  post '*not_found', to: 'application#routing_error'
end
