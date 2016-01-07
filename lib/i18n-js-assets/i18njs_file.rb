# encoding: UTF-8

require 'yaml'

module I18nJsAssets
  class I18nJsFile
    class << self
      def load(contents)
        from_hash(YAML.load(contents))
      end

      def load_file(file)
        load(File.read(file))
      end

      def from_hash(hash)
        new(hash)
      end
    end

    attr_reader :attributes

    def initialize(attributes)
      @attributes = attributes
    end

    def only
      attributes['only']
    end

    def locales
      attributes['locales']
    end

    def overwrite(new_attributes)
      self.class.from_hash(attributes.merge(new_attributes))
    end

    def write(path)
      File.write(path, dump)
    end

    def dump
      YAML.dump(attributes)
    end
  end
end
