Rails.application.routes.draw do
  devise_for :collaborators, path: 'collaborators'
  root 'home#index'

  resources :jobs, only: %i[index new create show]
end
