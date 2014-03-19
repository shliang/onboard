=======
onboard
=======

## From Scratch

rails new onboard --skip-test-unit --skip-bundle --database=postgresql
rails generate rspec:install

echo "gem 'devise'" >> GEMFILE ; bundle
rails generate devise:install
rails generate devise User; rake db:migrate

  5. You can copy Devise view:  > rails g devise:views


rails generate devise user

configure devise in user model and migration


## TODO

#confirmation not needed for service authentication
#Strong Params with Devise??

1. Omniauth
	* Twitter
	* Facebook
	* Github
* Figaro
* Add CanCan and/or Rolify
* Move to Rails 4.1
  * http://edgeguides.rubyonrails.org/upgrading_ruby_on_rails.html
  * http://edgeguides.rubyonrails.org/4_1_release_notes.html



Copyright (c) 2012-2014 Ken Decanio