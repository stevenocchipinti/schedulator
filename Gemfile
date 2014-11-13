source 'https://rubygems.org'
ruby '2.1.3'

gem 'rails', '~> 4.0.3'
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'jbuilder', '~> 1.2'
gem 'therubyracer', platforms: :ruby

gem 'chronic'


group :development, :test do
  gem 'sqlite3'

  gem 'rspec-rails'
  gem 'cucumber-rails', :require => false
  gem 'database_cleaner'
  gem 'timecop'
  gem 'launchy'
  gem 'poltergeist'

  gem 'pry-byebug'
  gem 'better_errors'
  gem 'binding_of_caller'
end


group :production do
  gem 'pg'
  gem 'thin'
  gem 'rails_12factor'
end
