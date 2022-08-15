Rails.application.routes.draw do

  devise_for :user,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    get '/home' => 'homes#top'
    resources :users
  end

  scope module: :public do
    root to: 'homes#top'
    get '/about' => 'homes#about'
    get '/sort' => 'homes#sort'

    resources :users, path: '/', param: :name_id do
      resources :diaries do
        resource :favorites, only: [:create, :destroy]
        resources :comments
        collection do
          get :history
        end
      end
      member do
        get :follows, :followers
      end
      resource :relationships, only: [:create, :destroy]
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
