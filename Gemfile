source 'https://rubygems.org'

gem 'rails', '~> 3.2.8'

# DRY on controllers
gem 'inherited_resources'


gem 'pg'
gem 'carrierwave'
gem 'mini_magick'
gem 'omniauth-facebook'
gem 'slim-rails'

group :test do
  gem 'cucumber-rails', :require => false
  gem 'database_cleaner'
  gem 'launchy'
end

group :test, :development do
  gem 'machinist', '>= 2.0.0.beta2'
  gem "rspec-rails", "~> 2.0"
end

group :production do
  gem "fog", "~> 1.3.1"
end


group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'uglifier', '>= 1.0.3'
  gem 'compass-rails'
  gem "compass-columnal-plugin"
end

gem 'jquery-rails'
