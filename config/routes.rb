Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  # /users/:id/follow 空陣列意思即為不使用devise的任何一個路徑
  resources :users, only: [] do
    member do
      post :follow
    end
  end

  resources :stories do
    member do
      post :clap
    end
    resources :comments, only: [:create]
  end

  #設定客製化網址
  get '@:username/:story_id', to: 'pages#show', as: 'story_page'
  get '@:username', to: 'pages#user', as: 'user_page'

  get '/demo', to: 'pages#demo'
  root 'pages#index'
end
