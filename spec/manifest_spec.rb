# encoding: UTF-8

require 'spec_helper'

include I18nJsAssets

describe Manifest do
  let(:manifest) do
    Manifest.new(app)
  end

  let(:source) { 'translations/includable.js' }
  let(:target) { 'target-%{locale}.js' }

  describe '#add' do
    it 'adds a new entry' do
      expect { manifest.add(source, target) }.to(
        change { manifest.entries.size }.by(1)
      )
    end
  end

  describe '#apply!' do
    it 'adds all entries to the base manifest' do
      manifest.add(source, target, locales: %w(en es))
      manifest.apply!

      entries = manifest.base_manifest.entries.map(&:logical_path).sort
      expect(entries).to eq(
        %w(target-en.js.i18njs target-es.js.i18njs)
      )
    end
  end
end
