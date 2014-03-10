Onboard::Application.routes.draw do

  devise_for :users
  root :to => "pages#home"

  get '/profiles' => 'users#profiles', as: 'user_profiles'

end
