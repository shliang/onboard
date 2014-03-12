Onboard::Application.routes.draw do

  devise_for :users

  ###
  # Static pages
  ###
  get "home"    => "pages#home",    as: "home"
  get "welcome" => "pages#welcome", as: "welcome"


  get '/profiles' => 'users#profiles', as: 'user_profiles'
  get '/profile/:id' => 'users#profile', as: 'user_profile'

  # # this goes to 'home' if signed in and 'welcome' if not
  # root :to => 'pages#home', :constraints => lambda {|r| r.env["warden"].authenticate? }
  # root :to => 'pages#welcome'

  authenticated :user do
    root to: "pages#home", as: :authenticated_root
  end

  unauthenticated do
    root to: "pages#welcome"
  end

end
