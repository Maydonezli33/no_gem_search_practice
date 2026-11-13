Rails.application.routes.draw do
  devise_for :users

  resources :cookings
  resources :genres

  root "cookings#index"
end