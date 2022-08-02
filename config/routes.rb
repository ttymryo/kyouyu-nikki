Rails.application.routes.draw do

  scope module: :public do
    root to: 'homes#top'
    get '/about' => 'homes#about'

    resources :users, path: '/', param: :name_id do
      resources :diaries do
        resource :favorites, only: [:create, :destroy]
        resources :comments
      end
      member do
        get :follows, :followers
      end
      resource :relationships, only: [:create, :destroy]
    end
  end

  devise_for :user,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
