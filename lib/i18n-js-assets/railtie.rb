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

    # this is for certain versions of rails 3 and rails 4
    config.after_initialize do |app|
      begin
        app.assets.register_engine('.i18njs', I18nJsAssets::Processor)
      rescue
      end
    end

    # this is for rails 4, sprockets 4
    #
    # (in this case the 'sprockets.environment' hook won't fire)
    if sprockets4?
      config.assets.configure do |env|
        i18n_processor_adapter = proc do |params|
          processor = I18nJsAssets::Processor.new { params[:data] }
          { data: processor.render }
        end

        env.register_mime_type 'text/i18njs', extensions: ['.i18njs', '.js.i18njs']
        env.register_transformer 'text/i18njs', 'application/javascript', i18n_processor_adapter
      end
    else
      # this is for rails 4, sprockets < 4
      initializer :i18n_js_assets, after: 'sprockets.environment' do |app|
        if app.assets
          app.assets.register_engine('.i18njs', I18nJsAssets::Processor)
        end
      end
    end
  end
end
