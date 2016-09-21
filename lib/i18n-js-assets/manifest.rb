# encoding: UTF-8

require 'generated-assets'
require 'yaml'

module I18nJsAssets
  class Manifest
    attr_reader :app, :entries, :base_manifest

    def initialize(app, prefix = nil)
      @app = app
      @prefix = prefix
      @entries = []
    end

    def add(source_path, target_path, options = {})
      entry = Entry.new(app, source_path, target_path, options)
      entries << entry
    end

    def apply!
      entries.each { |entry| entry.apply!(base_manifest) }
      base_manifest.apply!
    end

    def base_manifest
      @base_manifest ||= GeneratedAssets::Manifest.new(app, prefix)
    end

    def prefix
      @prefix ||= begin
        digest = Digest::SHA256.new
        I18n.load_path.sort.each { |path| digest << File.read(path) }

        File.join(
          Dir.tmpdir, 'i18n-js-assets', app.class.parent_name, digest.hexdigest
        )
      end
    end
  end
end
