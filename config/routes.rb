Rails.application.routes.draw do
  devise_for :candidates
  devise_for :collaborators, path: 'collaborators'
  root 'home#index'

  resources :jobs, only: %i[index new create show edit update candidate] do
    member do
      post 'disabled'
      get 'candidate'
    end
  end
  resources :companies, only: %i[index edit update show]
end
