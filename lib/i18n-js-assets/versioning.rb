# encoding: UTF-8

require 'sprockets/version'

module I18nJsAssets
  module Versioning
    def sprockets4?
      defined?(Sprockets) &&
        Sprockets::VERSION.to_f >= 4 &&
        Sprockets::VERSION.to_f < 5
    end
  end

  Versioning.extend(Versioning)
end
