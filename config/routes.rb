Rails.application.routes.draw do
  root to: "questions#index"
  
  devise_for :users, controllers: { omniauth_callbacks: 'oauth_callbacks' }

  concern :votable do
    member do
      post :like
      post :dislike
    end
  end

  concern :comment do
    resources :comments, only: :create
  end

  resources :questions, shallow: true, concerns: %i[votable comment] do
    resources :answers, shallow: true, except: :index, concerns: %i[votable comment] do
      member do
        patch :best
      end
    end
  end
  
  resources :attachments, only: :destroy
  resources :links, only: :destroy
  resources :awards, only: :index

  resource :authorization, only: %i[new create] do
    get 'email_confirmation/:confirmation_token', action: :email_confirmation, as: :email_confirmation
  end

  mount ActionCable.server => '/cable'
end
