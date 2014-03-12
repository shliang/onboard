=======
onboard
=======

== From Scratch

rails new onboard --skip-test-unit --skip-bundle --database=postgresql
rails generate rspec:install

echo "gem 'devise'" >> GEMFILE ; bundle
rails generate devise:install
rails generate devise User; rake db:migrate

  5. You can copy Devise view:  > rails g devise:views


rails generate devise user

## configure devise in user model and migration


Copyright (c) 2012-2014 Ken Decanio