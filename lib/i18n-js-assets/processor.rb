# encoding: UTF-8

module I18nJsAssets
  class Processor < ::Tilt::Template
    def prepare
      # noop
    end

    def evaluate(scope, locals, &block)
      options = (YAML.load(data) || {}).with_indifferent_access
      only = options.fetch(:only, '*')
      exceptions = [options.fetch(:except, [])].flatten

      # handle newer and older versions of i18n-js
      translations = if i18n_js.method(:segment_for_scope).arity == 2
        i18n_js.segment_for_scope(only, exceptions)
      else
        i18n_js.segment_for_scope(only)
      end

      construct_javascript_from(translations)
    end

    protected

    def construct_javascript_from(translations)
      %(I18n.translations || (I18n.translations = {});\n).tap do |result|
        translations.each_pair do |locale, locale_translations|
          result << construct_javascript_for_locale(locale, locale_translations)
        end
      end
    end

    def construct_javascript_for_locale(locale, translations)
      %(I18n.translations["#{locale}"] = #{translations.to_json};\n)
    end

    def i18n_js
      if Kernel.const_defined?(:SimplesIdeias)
        SimplesIdeias::I18n
      else
        I18n::JS
      end
    end
  end
end
