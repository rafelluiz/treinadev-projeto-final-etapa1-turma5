Rails.application.routes.draw do
  devise_for :candidates
  devise_for :collaborators, path: 'collaborators'
  root 'home#index'

  resources :jobs, only: %i[index new create show edit update candidate apply] do
    member do
      post 'apply'
      post 'disabled'
      get 'candidate'
    end
  end
  resources :companies, only: %i[index edit update show]
  resources :apply_fors, only: %i[index]
  resources :candidates, only: %i[show]
end
