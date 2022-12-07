Rails.application.routes.draw do
  devise_for :users
  root to: "questions#index"
  
  resources :questions, shallow: true do
    resources :answers, shallow: true, except: :index
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
