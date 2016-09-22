# encoding: UTF-8

require 'digest'
require 'i18n-js-assets'

module I18nJsAssets
  class Railtie < ::Rails::Railtie
    include Versioning

    config.before_configuration do |app|
      app.config.assets.localized = I18nJsAssets::Manifest.new(app)
    end

    config.after_initialize do |app|
      app.config.assets.paths << app.config.assets.localized.prefix
      app.assets.append_path(app.config.assets.localized.prefix)
      app.config.assets.localized.apply!
    end

    config.assets.configure do |env|
      if env.respond_to?(:register_transformer)
        env.register_mime_type 'text/i18njs', extensions: ['.i18njs', '.js.i18njs']
        env.register_transformer 'text/i18njs', 'application/javascript', I18nJsAssets::Transformer
      end

      if env.respond_to?(:register_engine)
        %w(.i18njs .js.i18njs).each do |extension|
          args = [extension, I18nJsAssets::Transformer]

          if Sprockets::VERSION.start_with?('3')
            args << { mime_type: 'text/i18njs', silence_deprecation: true }
          end

          env.register_engine(*args)
        end
      end
    end
  end
end
