source 'https://rubygems.org'

gemspec

if ENV['SPROCKETS_VERSION'].to_f == 4
  gem 'sprockets', '4.0.0.beta3'
else
  gem 'sprockets', "~> #{ENV['SPROCKETS_VERSION'] || '3.0'}"
end

group :development, :test do
  gem 'tilt'

  gem 'pry-nav'
  gem 'rake'
  gem 'rspec'
end
