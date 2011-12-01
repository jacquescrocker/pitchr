source 'http://rubygems.org'

gem "sprockets", :git => "git://github.com/railsjedi/sprockets.git"

gem "rake", "0.8.7"
gem 'rails', '3.1.3'

gem "bcrypt-ruby"

# Rails 3.1 - Asset Pipeline
gem 'json'

gem 'jquery-rails'

gem "bson", "1.4.0"
gem "bson_ext", "1.4.0"
gem "mongo", "1.4.0"
gem "mongoid", ">= 2.3.2"

gem "rails_config", ">= 0.2.3"

gem "useragent"
gem "viewfu", ">= 1.0.1"
gem 'rack', '1.3.5'
gem "rack-mobile-detect", :require => 'rack/mobile-detect'

gem "redis"
gem "resque"
gem "resque-scheduler"
gem "airbrake"

# sprite
gem "rmagick"

# gem "sprite", :path => "~/Gems/sprite"
gem "sprite", ">= 0.2.5"

gem "pusher"

gem 'validate_email'

# stripe will handle our saas billing to merchants
gem "stripe", ">= 1.5.21"

# hirefire allows us to autoscale our heroku dynos and workers
gem "hirefireapp"

gem "thin"
gem "unicorn"

gem 'chronic'

# facebook library for Ruby, supporting the Graph API (including the batch requests and photo uploads), the REST API, realtime updates, test users, and OAuth validation
gem 'koala'


group :assets do
  gem 'handlebars_assets'

  gem 'execjs', :git => 'git://github.com/sstephenson/execjs.git'

  gem "sass", "3.1.10"
  gem "sass-rails", "3.1.4"
  gem "compass", ">= 0.12.alpha"

  gem "coffee-rails"
  gem "uglifier"
  gem 'yui-compressor', :require => 'yui/compressor'
end

group :development do
  gem "launchy", "~> 0.3.7"
  gem "heroku-rails", ">= 0.3.2"

  # setup guard
  gem "guard"
  gem "guard-pusher", :git => "http://github.com/railsjedi/guard-pusher.git"
  gem "guard-coffeescript", ">= 0.4.0"
  # gem "guard-resque", :path => "~/Gems/guard-resque"
  gem "guard-resque", ">= 0.0.2"

  # terminiator is nice
  gem "terminitor", ">= 0.6.0"
end

group :development, :test do

  gem "ruby-debug", :platforms => :mri_18
  gem "ruby-debug19", :platforms => :mri_19, :require => 'ruby-debug'

  gem "fabrication"
  gem 'ffaker'
  gem "rspec-rails", ">= 2.5.0"

  gem "rb-fsevent"
  gem "growl"
  gem 'growl_notify'

end

group :test do
  gem "webmock", :require => nil
  gem "vcr", :require => nil
  gem 'capybara'
  # gem 'webrat'

  gem "pickle"

  gem 'spork', '>= 0.9.0.rc9'
  gem 'guard-spork'
  gem 'guard-rspec'
  gem 'guard-cucumber'

  # gem "mongoid-rspec", ">= 1.4.4"
  gem 'remarkable_mongoid'
  gem 'cucumber-rails', '>= 1.0.2' # cannot run with capybara webkit due to dependency problems

  gem 'factory_girl_rails'

  # Pretty printed test output
  gem 'turn', '0.8.2', :require => false
end
