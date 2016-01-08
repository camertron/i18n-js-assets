# encoding: UTF-8

require 'spec_helper'

include I18nJsAssets

describe Entry do
  let(:entry) do
    Entry.new(
      app, source_path, target_path, {
        precompile: locales
      }
    )
  end

  let(:source_path) do
    'translations/precompilable.js'
  end

  let(:target_path) do
    'translations/precompilable-%{locale}.js'
  end

  let(:locales) do
    [:en, :es]
  end

  describe '#apply!' do
    it 'adds entries for each locale' do
      entry.apply!

      paths = app.config.assets
        .generated.entries.map(&:logical_path)
        .sort

      expect(paths).to(
        eq([
          'translations/precompilable-en.js.i18njs',
          'translations/precompilable-es.js.i18njs'
        ])
      )
    end
  end
end
