Rails.application.routes.draw do
  mount ActionCable.server => "/cable"
  devise_for :users, controllers: {
  registrations: "users/registrations"
  }
  root to: "pages#home"
  resources :city_interests, only: [:new, :create]
  get "/users/search", to: "users#search", as: :search_users
  get "/users/check_email", to: "users#check_email", as: :check_email_users
  resources :shares, only: [:create] do
    member { patch :mark_read }
  end

  get "sobre", to: "pages#about", as: :about

  resource :profile, only: [:new, :create, :show, :edit, :update]

  resources :events do
    resources :attendances, only: [:create, :destroy]
    resources :reviews, only: [:create, :new]
    resources :messages, only: [:create]
    collection do
      get :confirmed
      get :past
    end
  end
  get "/chats", to: "chats#index", as: :chats
  post "/attendances/mark_seen", to: "attendances#mark_seen", as: :mark_seen_attendances
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
