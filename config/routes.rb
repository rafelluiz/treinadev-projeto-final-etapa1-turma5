Rails.application.routes.draw do
  devise_for :collaborators, path: 'collaborators'
  root 'home#index'

  resources :jobs, only: %i[index new create show edit update]
  resources :companies, only: %i[edit update show]
end
