source 'https://rubygems.org'

gem 'rails', '3.2.9'

gem "bootstrap-sass", ">= 2.1.1.0"
gem "cancan", ">= 1.6.8"
gem "devise", ">= 2.1.2"
gem "devise_invitable", ">= 1.1.4"
gem "figaro", ">= 0.5.0"
gem "pg", ">= 0.14.1"
gem "haml", ">= 3.1.7"
# gem "thin", ">= 1.5.0"
gem "unicorn"
gem "sendgrid", ">= 1.0.1"
gem "rolify", ">= 3.2.0"
gem "vanity", :git => 'git://github.com/verticalbrands/vanity.git', :tag => "vb1.9.0"
gem "rails_admin"
# gem "delayed_job_active_record"

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

group :development do
	gem "better_errors", ">= 0.2.0"
	gem "binding_of_caller", ">= 0.6.8"
	gem "haml-rails", ">= 0.3.5"
	gem "hpricot", ">= 0.8.6"
	gem "letter_opener"
	gem "quiet_assets", ">= 1.0.1"
	gem "ruby_parser", ">= 3.1.0"
end

group :test do
	gem "capybara", ">= 2.0.1"
	gem "database_cleaner", ">= 0.9.1"
	gem "email_spec", ">= 1.4.0"
end

group :development, :test do
	gem "factory_girl_rails", ">= 4.1.0"
	gem "rspec-rails", ">= 2.11.4"
end

group :production do
	gem 'rack-google_analytics', require: 'rack/google_analytics'
end
