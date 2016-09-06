# encoding: UTF-8

require 'i18n-js-assets'

module I18nJsAssets
  class Railtie < ::Rails::Railtie
    include Versioning

    config.before_configuration do |app|
      app.config.assets.localized = I18nJsAssets::Manifest.new(app)
    end

    config.before_initialize do |app|
      app.config.assets.generated.before_apply do
        app.config.assets.localized.apply!
      end
    end

    config.assets.configure do |env|
      # To ensure that updated i18n assets get reloaded, we need to make sure Sprockets knows about the .yml dependencies.
      # Changing the dependencies via environment-paths (generated based off env.paths which we modify here) seems to be the best solution for now
      # The downside is that the entire cache is recompiled when an i18n .yml changes
      digest = Digest::SHA256.new
      I18n.load_path.each { |path| digest << File.read(path) }
      env.append_path(File.join("#{GeneratedAssets.asset_dir}/i18n-js-assets-#{digest.hexdigest}"))
    end

    # this is for certain versions of rails 3 and rails 4
    config.after_initialize do |app|
      begin
        app.assets.register_engine('.i18njs', I18nJsAssets::Processor)
      rescue
      end
    end

    # this is for rails 3/4, sprockets < 4
    if !sprockets4?
      initializer :i18n_js_assets, after: 'sprockets.environment' do |app|
        if app.assets
          app.assets.register_engine('.i18njs', I18nJsAssets::Processor)
        end
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
    end
  end
end
