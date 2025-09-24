source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.4.4'

gem 'bootsnap', '1.18.6', require: false
gem 'coffee-rails', '5.0.0'
gem 'jbuilder', '2.14.1'
gem 'mysql2', '0.5.7'
gem 'puma', '6.6.0'
gem 'rails', '8.0.3'
gem 'sass-rails', '6.0.0'
gem 'turbolinks', '5.2.1'
gem 'uglifier', '4.2.1'
gem 'webpacker'

group :development do
  gem "listen"
  gem "spring"
  gem "spring-commands-rspec"
  gem "spring-watcher-listen", "2.1.0"
  gem "web-console", "4.2.1"
  gem "brakeman"
end

group :development, :test do
  gem "awesome_print"
  gem "dotenv-rails"
  gem "factory_bot_rails"
  gem "pry-byebug"
  gem "pry-rails"
  gem "rspec-rails", "8.0.0"
end

group :test do
  gem "capybara-selenium"
  gem "webdrivers"
  gem "shoulda-matchers"
  gem "simplecov", require: false
end
