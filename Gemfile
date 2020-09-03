source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'
gem 'rails', '~> 6.0.3', '>= 6.0.3.2'

gem 'uglifier'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'webpacker', '~> 4.x'

gem 'email_validator'

group :production do
  gem 'pg'
end

group :development, :test do
  gem 'sqlite3', '~> 1.4'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.2'
end

