# encoding: UTF-8

module I18nJsAssets
  class Railtie < ::Rails::Railtie
    initializer :i18n_js_assets, group: :all do |app|
      app.assets.register_engine('.i18njs', I18nJsAssets::Processor)
    end
  end
end
