# encoding: UTF-8

require 'yaml'

module I18nJsAssets
  class Manifest
    attr_reader :app, :entries

    def initialize(app)
      @app = app
      @entries = []
    end

    def add(source_path, target_path, options = {})
      entry = Entry.new(app, source_path, target_path, options)
      entries << entry
    end

    def apply!
      entries.each(&:apply!)
    end
  end
end
