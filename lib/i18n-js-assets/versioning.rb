# encoding: UTF-8

require 'sprockets/version'

module I18nJsAssets
  module Versioning
    def rails3?
      defined?(Rails) &&
        Rails::VERSION::STRING.to_f >= 3 &&
        Rails::VERSION::STRING.to_f < 4
    end

    def rails4?
      defined?(Rails) &&
        Rails::VERSION::STRING.to_f >= 4 &&
        Rails::VERSION::STRING.to_f < 5
    end

    def sprockets4?
      defined?(Sprockets) &&
        Sprockets::VERSION.to_f >= 4 &&
        Sprockets::VERSION.to_f < 5
    end
  end

  Versioning.extend(Versioning)
end
