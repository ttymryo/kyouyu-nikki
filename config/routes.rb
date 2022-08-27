Rails.application.routes.draw do

  devise_for :user,skip: [:passwords, :registrations], controllers: {
    sessions: 'public/sessions'
  }

  devise_scope :user do
    get 'user/sign_up', to: 'public/registrations#new', as: :new_user_registration
    post 'user/sign_up', to: 'public/registrations#create', as: :user_registration
    post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    get '/home' => 'homes#top'
    resources :diaries, except: [:new, :create, :index]
    resources :users, except: [:new, :create]
    delete '/comments/:id', to: 'diaries#comments', as: :comment
  end

  scope module: :public do
    root to: 'homes#top'
    get '/about' => 'homes#about'
    get '/sort' => 'homes#sort'
    get '/search' => 'searches#search'

    resources :users, path: '/', param: :name_id do
      resources :diaries, except: [:index, :create] do
        resource :favorites, only: [:create, :destroy]
        resources :comments, only: [:destroy]
        post '/', to: 'comments#create', as: :comments
        collection do
          get :history
          post 'new', to: 'diaries#create'
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
