$:.unshift File.join(File.dirname(__FILE__), 'lib')
require 'i18n-js-assets/version'

Gem::Specification.new do |s|
  s.name     = "i18n-js-assets"
  s.version  = ::I18nJsAssets::VERSION
  s.authors  = ["Cameron Dutro"]
  s.email    = ["camertron@gmail.com"]
  s.homepage = "http://github.com/camertron"

  s.description = s.summary = 'Compile your Javascript translations using the asset pipeline instead of rake tasks.'

  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true

  if ENV['RAILS_VERSION']
    s.add_dependency 'railties', "~> #{ENV['RAILS_VERSION']}"
  else
    s.add_dependency 'railties', '>= 3.2.0', '< 5'
  end

  s.add_dependency 'generated-assets', '~> 1.0'
  s.add_dependency 'i18n-js'
  s.add_dependency 'sprockets-rails'
  s.add_dependency 'tilt'
  s.add_dependency 'tzinfo'

  s.require_path = 'lib'
  s.files = Dir["{lib,spec}/**/*", "Gemfile", "README.md", "Rakefile", "i18n-js-assets.gemspec"]
end
