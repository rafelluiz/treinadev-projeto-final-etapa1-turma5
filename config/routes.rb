Rails.application.routes.draw do
  root 'home#index'

  resources :jobs, only: %i[index new create]
end
