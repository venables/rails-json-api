source 'https://rubygems.org'
ruby '2.0.0'

gem 'rake', '10.0.4'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0.rc2'

gem 'pg'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 4.0.0.rc2'
  gem 'coffee-rails', '~> 4.0.0.rc2'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', platforms: :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.4.2'

# To use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.0.1'

# Use unicorn as the app server
gem 'unicorn', '~> 4.6.2'

# Deploy with Capistrano
# gem 'capistrano', group: :development

# To use debugger
# gem 'debugger'

gem 'haml-rails', '~> 0.4'

group :development do
  gem 'foreman', require: false
  gem 'letter_opener', '~> 1.1.0'
end

group :development, :test do
  gem 'factory_girl_rails', '~> 4.2.1'
  gem 'pry-rails'
  gem 'rspec-rails',        '~> 2.14.0.rc1'
end

group :test do
  gem 'email_spec',       '~> 1.4.0'
  gem 'database_cleaner', '~> 1.0.1'
  gem 'faker',            '~> 1.1.2'
  gem 'shoulda-matchers', '~> 2.2.0'
  gem 'simplecov',        '~> 0.7.1', require: false
end
