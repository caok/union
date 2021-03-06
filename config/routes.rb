Union::Application.routes.draw do

  resources :badges, :except =>[:show] do
    member do
      get 'load_award_modal'
    end

    collection do
      post 'award'
      get 'users'
    end
  end

  resources :messages, :only => [:index, :destroy] do
    collection do
      post 'clear'
    end
  end

  resources :notices

  resources :commits

  resources :repositories

  resources :records

  resources :participations

  resources :grades

  resources :activities do
    member do
      post :register
    end

    resources :comments
  end

  post 'comment/preview', to: 'comments#preview', as: 'comment_preview'

  resources :projects do
    member do
      post 'join'
      post 'quit'
      post 'finish'
    end
  end


  get "home/index"
  get :instruction, to: 'home#instruction', as: 'instruction'
  get :union_report, to: 'home#union_report', as: 'union'
  get 'ongoing', to: 'projects#ongoing', as: 'ongoing'


  get 'users/sign_up' => redirect("/")
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  authenticated :user do
    root to: "home#index"
  end

  as :user do
    root :to => 'projects#ongoing'
    get 'account' => 'registrations#edit', :as => 'account'
  end

  get "/ranking" => "users#ranking", as: "rankings"
  get "/users" => "users#index", as: "users"
  get "/user/:id/edit" => "users#edit", as: "edit_user"
  get "search" => "projects#ongoing"
  get 'badges/:name_en', to: 'badges#show', as: 'show_badge'
  get "comments/create"

  resources :users, :only => [] do
    member do
      get 'badges'
    end
  end
  resources :users, :path => '', :only => [:show, :update]
end
