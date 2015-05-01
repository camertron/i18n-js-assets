# encoding: UTF-8

module I18nJsAssets
  class Processor < ::Tilt::Template
    def prepare
      # noop
    end

    def evaluate(scope, locals, &block)
      options = YAML.load(data).with_indifferent_access
      only = options.fetch(:only, '*')
      exceptions = [options.fetch(:except, [])].flatten

      # handle newer and older versions of i18n-js
      translations = if I18n::JS.method(:segment_for_scope).arity == 2
        I18n::JS.segment_for_scope(only, exceptions)
      else
        I18n::JS.segment_for_scope(only)
      end

      result = %(I18n.translations || (I18n.translations = {});\n)
      translations.each_pair do |locale, translations_for_locale|
        result << %(I18n.translations["#{locale}"] = #{translations_for_locale.to_json};\n);
      end

      result
    end
  end
end
