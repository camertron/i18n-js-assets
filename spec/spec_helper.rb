# encoding: UTF-8

require 'rake'
require 'rspec'
require 'fileutils'
require 'pry-nav'

require 'rails'
require 'sprockets/railtie'

ENV['RAILS_ENV'] ||= 'test'

require 'i18n-js-assets'

Dir.chdir('spec') do
  require File.expand_path('../config/application', __FILE__)
  I18nJsAssets::DummyApplication.initialize!
  I18nJsAssets::DummyApplication.load_tasks  # used by precompilation specs
end

module LetDeclarations
  extend RSpec::SharedContext

  let(:en_source) do
    %Q(I18n.translations["en"] = I18n.extend((I18n.translations["en"] || {}), {"my_app":{"teapot":"I'm a little teapot"}});)
  end

  let(:es_source) do
    %Q(I18n.translations["es"] = I18n.extend((I18n.translations["es"] || {}), {"my_app":{"teapot":"Soy una tetera pequeña"}});)
  end

  let(:assets_config) do
    app.config.assets
  end

  let(:app) do
    Rails.application
  end

  let(:asset_path) do
    Pathname(
      File.join(Rails.public_path, assets_config.prefix)
    )
  end
end

RSpec.configure do |config|
  config.include(LetDeclarations)

  def unescape_unicode(str)
    str.gsub(/\\u([\da-fA-F]{4})/) do |m|
      [$1].pack('H*').unpack('n*').pack('U*')
    end
  end

  config.before(:each) do
    FileUtils.rm_rf(
      I18nJsAssets::DummyApplication.root.join('tmp').to_s
    )

    FileUtils.rm_rf(
      I18nJsAssets::DummyApplication.root.join('public').to_s
    )

    FileUtils.rm_rf(
      app.config.assets.generated.prefix
    )

    app.config.assets.generated.entries.clear
  end
end
