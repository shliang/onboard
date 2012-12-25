Onboard::Application.routes.draw do


  # get "service/create"
  # get "service/destroy"
  # get "service/failure"
  # get "service/index"
  # get "service/facebook"
  # get "service/twitter"

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
  
  # Vanity
  match '/vanity(/:action(/:id(.:format)))', :controller=>:vanity

  root to: "pages#welcome"
end
