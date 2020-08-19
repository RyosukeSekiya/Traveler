Rails.application.routes.draw do
  resources :posts
  root to: 'toppages#index'
 
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'   
  } 

  devise_scope :user do
    get "sign_in", :to => "users/sessions#new"
    get "sign_out", :to => "users/sessions#destroy" 
  end

  get "users/:id" => "users#show", as: :mypage
  
  
end
