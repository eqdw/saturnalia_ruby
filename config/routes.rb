Rails.application.routes.draw do
  root to: "pairs#dashboard"
  resources :exclusions
  resources :teams
  resources :people

  resources :pairs do
    collection do
      get  :dashboard,      as: "dashboard"
      get  :generate_pairs, as: "generate"
      post :create_pairs,   as: "create"
    end
  end
end
