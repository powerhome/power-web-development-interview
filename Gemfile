source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.6'

gem 'bootsnap', '>= 1.1.0', require: false
gem 'coffee-rails', '~> 5.0'
gem 'jbuilder', '~> 2.5'
gem 'mysql2', '>= 0.4.4', '< 0.6.0'
gem 'puma', '~> 4.0'
gem 'rails', '~> 5.2.1'
gem 'sass-rails', '~> 6.0'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'
gem 'webpacker'

group :development do
  gem "listen", ">= 3.0.5", "< 3.7.2"
  gem "spring"
  gem "spring-commands-rspec"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
end

group :development, :test do
  gem "awesome_print"
  gem "dotenv-rails"
  gem "factory_bot_rails"
  gem "pry-byebug"
  gem "pry-rails"
  gem "rspec-rails", "~> 5.0"
end

group :test do
  gem "capybara-selenium"
  gem "chromedriver-helper"
  gem "shoulda-matchers"
  gem "simplecov", require: false
end
