Onboard::Application.routes.draw do


  devise_for :users
  # Feel free to change '/admin' to any namespace you need.
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  # Static pages
  get "home" => "pages#home", as: "home"
  get "welcome" => "pages#welcome", as: "welcome"
  get "about" => "pages#about", as: "about"
  get "contact" => "pages#contact", as: "contact"
  get "terms" => "pages#terms", as: "terms"
  get "privacy" => "pages#privacy", as: "privacy"

  root to: "pages#welcome"
end
