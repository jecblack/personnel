Rails.application.routes.draw do
  root :to => "visitors#index"
  get 'tags/:tag', to: 'people#index', as: :tag
  devise_for :users
  resources :users
  resources :people
  resources :categories
end
