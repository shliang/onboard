Onboard::Application.routes.draw do

  devise_for :users, controllers: {omniauth_callbacks: "services"}
  delete '/services/destroy', to: 'users#destroy_service', as: :destroy_user_omniauth

  ###
  # Static pages
  ###
  get "home"    => "pages#home",    as: "home"
  get "welcome" => "pages#welcome", as: "welcome"


  ###
  # other routes
  ###
  get '/profiles' => 'users#profiles', as: 'user_profiles'
  get '/profile/:id' => 'users#profile', as: 'user_profile'

  ###
  # root path depends on authentication
  ###
  authenticated :user do
    root to: "pages#home", as: :authenticated_root
  end

  unauthenticated do
    root to: "pages#welcome"
  end

end
