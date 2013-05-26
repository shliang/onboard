Onboard::Application.routes.draw do

  # resources :fbs
  # get '/fb' => 'fbs#profile', as: 'fb_profile'

  match '/auth/:provider/callback' => 'services#authenticate'

  devise_for :users, controllers: {omniauth_callbacks: "services"}

  # Feel free to change '/admin' to any namespace you need.
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  # Static pages
  get "home"    => "pages#home",    as: "home"
  get "welcome" => "pages#welcome", as: "welcome"
  get "about"   => "pages#about",   as: "about"
  get "contact" => "pages#contact", as: "contact"
  get "terms"   => "pages#terms",   as: "terms"
  get "privacy" => "pages#privacy", as: "privacy"
  
  # User
  get '/account' => 'users#account', as: 'user_show'
  get '/profiles' => 'users#profiles', as: 'user_profiles'
  match '/profile' => redirect('/profiles')
  get '/profile/:id' => 'users#profile', as: 'user_profile'
  resources :users, only: [:update]
  
  # Vanity
  match '/vanity(/:action(/:id(.:format)))', :controller=>:vanity

  match '/' => 'pages#welcome', :constraints => { :subdomain => /.+/ }

  # this goes to 'home' if signed in and 'welcome' if not
  root :to => 'pages#home', :constraints => lambda {|r| r.env["warden"].authenticate? }
  root :to => 'pages#welcome'

  # get "/" => 'users#dashboard', :as => "user_root"
end
