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

    # this is for rails 4, sprockets < 4
    initializer :i18n_js_assets, after: 'sprockets.environment' do |app|
      if app.assets
        app.assets.register_engine('.i18njs', I18nJsAssets::Processor)
      end
    end

    # this is for rails 4, sprockets 4
    #
    # (in this case the 'sprockets.environment' hook won't fire)
    if defined?(Sprockets) && Sprockets::VERSION.to_f >= 4
      config.assets.configure do |env|
        i18n_processor_adapter = proc do |params|
          processor = I18nJsAssets::Processor.new { params[:data] }
          { data: processor.render }
        end

        env.register_mime_type 'text/i18njs', extensions: ['.i18njs', '.js.i18njs']
        env.register_transformer 'text/i18njs', 'application/javascript', i18n_processor_adapter
      end
    end
  end
end
