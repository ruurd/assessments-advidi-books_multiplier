# encoding: UTF-8
#============================================================================
# Copyright (c) Bureau Pels.  All Rights Reserved.
#============================================================================
source 'https://rubygems.org'

# Regular RAILS stuff
gem 'rails', '3.2.13'
gem 'rails-i18n'
gem 'rails_config'
gem 'pg'
gem 'activerecord-postgresql-adapter'
gem 'delayed_job_active_record'

# Background stuff
gem 'thin'
gem 'mail'
gem 'unicorn'
gem 'newrelic_rpm'

# Web UI stuff
gem 'haml'
gem 'jquery-rails'
gem 'twitter-bootstrap-rails'
gem 'kaminari'
gem 'kaminari-bootstrap'
gem 'simple_form'

#group :assets do
gem 'uglifier'
gem 'therubyracer'
gem 'less-rails'
gem 'coffee-rails'
gem 'asset_sync'
gem 'less-rails-bootstrap'
gem 'therubyrhino'
#end

group :development do
  gem 'quiet_assets'
  gem 'capistrano'
  gem 'rvm-capistrano'
  gem 'kwalify'
  gem 'brakeman'
  gem 'cane'
  gem 'ruby-prof'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request', '0.2.1'
end

group :test, :development do
  gem 'guard'
  gem 'guard-rails'
  gem 'guard-test'
  gem 'guard-rubocop'
  gem 'terminal-notifier-guard'
end

group :test do
  gem 'minitest-reporters'
  gem 'factory_girl'
  gem 'shoulda'
  gem 'shoulda-matchers'
end

group :cucumber do
  #gem 'cucumber'
  #gem 'cucumber-rails'
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'pickle'
  gem 'launchy'
  gem 'rspec-rails'
  gem 'syntax'
end


