Rails.application.routes.draw do
  resources :teams
  resources :people
  resources :exclusions
  resources :pairs
  resources :pairs
  root to: "pairs#dashboard"
  resources :exclusions
  resources :teams
  resources :people

  resources :pairs do
    get :dashboard
  end
end
