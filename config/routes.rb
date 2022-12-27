Rails.application.routes.draw do
  root to: "questions#index"
  
  devise_for :users

  concern :votable do
    member do
      post :like
      post :dislike
    end
  end

  resources :questions, shallow: true, concerns: [:votable] do
    resources :answers, shallow: true, except: :index, concerns: [:votable] do
      member do
        patch :best
      end
    end
  end
  
  resources :attachments, only: :destroy
  resources :links, only: :destroy
  resources :awards, only: :index

end
