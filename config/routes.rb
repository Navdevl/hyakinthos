Rails.application.routes.draw do
  get 'organizations/match_rules'
  devise_for :users

  root to: 'organizations#index'
  
  resources :organizations do 
    member do
      post 'match_rules'
      get 'match_rules/new', to: 'organizations#new_match_rules'
    end
  end
  resources :match_rules

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :organizations, only: [] do 
        collection do 
          get 'search'
        end
      end
    end
  end
end
