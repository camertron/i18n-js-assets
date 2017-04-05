# encoding: UTF-8

require 'i18n-js'

module I18nJsAssets
  class Transformer
    class << self
      def run(filename, source, context)
        options = (YAML.load(source) || {}).with_indifferent_access
        only = options.fetch(:only, '*')
        exceptions = [options.fetch(:except, [])].flatten

        # add dependencies to this asset so that any changes to files on the
        # I18n load path cause this asset to be recompiled
        I18n.load_path.each do |path|
          context.depend_on(path)
        end

        # handle newer and older versions of i18n-js
        translations = if i18n_js.method(:segment_for_scope).arity == 2
          i18n_js.segment_for_scope(only, exceptions)
        else
          i18n_js.segment_for_scope(only)
        end

        locales = options.fetch(:locales, translations.keys).map(&:to_sym)
        construct_javascript_from(locales, translations)
      end

      def call(input)
        filename = input[:filename]
        source   = input[:data]
        context  = input[:environment].context_class.new(input)

        result = run(filename, source, context)
        context.metadata.merge(data: result)
      end

      private

      def construct_javascript_from(locales, translations)
        %(var I18n = I18n || {}; I18n.translations || (I18n.translations = {});\n).tap do |result|
          translations.each_pair do |locale, locale_translations|
            next unless locales.include?(locale)
            result << construct_javascript_for_locale(locale, locale_translations)
          end
        end
      end

      def construct_javascript_for_locale(locale, translations)
        %{I18n.translations["#{locale}"] = I18n.extend((I18n.translations["#{locale}"] || {}), #{translations.to_json});\n}
      end

      def i18n_js
        if Kernel.const_defined?(:SimplesIdeias)
          SimplesIdeias::I18n
        else
          I18n::JS
        end
      end
    end

    def initialize(filename, &block)
      @filename = filename
      @source = block.call
    end

    def render(context, empty_hash_wtf)
      self.class.run(@filename, @source, context)
    end
  end
end
