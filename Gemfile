source 'https://rubygems.org'

gemspec

if ENV['SPROCKETS_VERSION'].to_f == 4
  gem 'sprockets', '4.0.0.beta2'
else
  gem 'sprockets', "~> #{ENV['SPROCKETS_VERSION'] || '3.0'}"
end

group :development, :test do
  gem 'rake'
  gem 'rspec'
  gem 'pry-byebug'
  gem 'wwtd'
end
