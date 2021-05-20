# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.2'
# Use Puma as the app server
gem 'puma', '~> 4.3'
# Use SCSS for stylesheets
gem 'sass-rails'
gem 'bootstrap', '~> 4.5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier'
gem 'jquery-rails'
gem 'activesupport-current_attributes'

### AUTHENTICATION
gem 'devise'
gem 'devise-i18n'
gem 'devise-security'
gem 'pundit'

### VIEWS
gem 'simple_form'
gem 'slim'
gem 'slim-rails'

### MODEL
gem 'aasm'
gem 'paper_trail'

### MONEY
gem 'money-rails'

group :development, :test do
  gem 'faker', :git => 'https://github.com/faker-ruby/faker.git', :branch => 'master'
  gem 'pry', '~> 0.10.4'
end

group :test do
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'rails-controller-testing'
  gem 'rspec-mocks'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'webmock'
end

group :development do
  gem 'listen'
  gem 'rubocop', require: false
end
