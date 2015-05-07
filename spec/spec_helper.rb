# encoding: UTF-8

require 'rspec'
require 'pry-nav'

require 'rails'
require 'tilt'
require 'i18n-js'
require 'sprockets/railtie'

ENV['RAILS_ENV'] ||= 'test'

module I18nJsAssets
  class DummyApplication < ::Rails::Application
    config.eager_load = false
    config.assets.enabled = true
    config.assets.compile = true
    config.assets.allow_debugging = true
    config.root = config.root.join('./spec')  # app lives in ./spec
  end
end

require 'i18n-js-assets'

I18nJsAssets::DummyApplication.initialize!

RSpec.configure do |config|
  def unescape_unicode(str)
    str.gsub(/\\u([\da-fA-F]{4})/) do |m|
      [$1].pack('H*').unpack('n*').pack('U*')
    end
  end
end
