# encoding: UTF-8

require 'spec_helper'

include I18nJsAssets

describe Manifest do
  let(:manifest) do
    Manifest.new(app)
  end

  describe '#add' do
    it 'adds a new entry' do
      expect { manifest.add('source.js', 'target.js') }.to(
        change { manifest.entries.size }.by(1)
      )
    end
  end

  describe '#apply!' do
    it 'adds all entries to the generated assets list' do
      manifest.add('source.js', 'target-%{locale}.js', locales: %w(en es))
      manifest.apply!

      entries = app.config.assets.generated.entries.map(&:logical_path).sort
      expect(entries).to eq(
        %w(target-en.js.i18njs target-es.js.i18njs)
      )
    end
  end
end
