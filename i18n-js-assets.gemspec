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

  s.add_dependency 'i18n-js'
  s.add_dependency 'railties', '>= 3.1.0'

  s.require_path = 'lib'
  s.files = Dir["{lib,spec}/**/*", "Gemfile", "History.txt", "README.md", "Rakefile", "i18n-js-assets.gemspec"]
end
