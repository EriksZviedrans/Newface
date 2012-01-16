Newface::Application.routes.draw do 

  get "login" => "sessions#new", :as => "log_in"
  get "log_out" => "sessions#destroy", :as => "log_out"
  get "sign_up" => "users#new", :as => "sign_up"
  get "people" => "users#people", :as => "people"
  get "friends_online" => "users#friends_online", :as => "friends_online"
  get "users/search" => "users#search", :as => "users/search"

  resources :users do
    resources :events
  end
  resources :events
  resources :sessions
  match 'code_image/:id' => 'users#code_image'
  match 'users/invite/:id' => 'users#invite', :as => 'invite_friend'
  match 'users/accept/:id' => 'users#accept'
  match 'users/decline/:id' => 'users#decline'
  match 'search' => 'users#search'
  match 'autocomplete/users' => "autocomplete#users"

  root :to => 'sessions#new'
end
