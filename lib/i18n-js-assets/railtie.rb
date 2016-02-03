# encoding: UTF-8

module I18nJsAssets
  class Railtie < ::Rails::Railtie
    config.before_configuration do |app|
      app.config.assets.localized = I18nJsAssets::Manifest.new(app)
    end

    config.before_initialize do |app|
      app.config.assets.generated.before_apply do
        app.config.assets.localized.apply!
      end
    end

    # this is for rails 3
    config.after_initialize do |app|
      begin
        app.assets.register_engine('.i18njs', I18nJsAssets::Processor)
      rescue
      end
    end

    # this is for rails 4
    initializer :i18n_js_assets, after: 'sprockets.environment' do |app|
      if app.assets
        app.assets.register_engine('.i18njs', I18nJsAssets::Processor)
      end
    end
  end
end
