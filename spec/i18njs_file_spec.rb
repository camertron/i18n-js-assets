# encoding: UTF-8

require 'spec_helper'
require 'fileutils'

include I18nJsAssets

describe I18nJsFile do
  let(:file) do
    I18nJsFile.load(contents)
  end

  let(:contents) do
    YAML.dump(
      'only' => '*.my_app.*',
      'locales' => %w(en es)
    )
  end

  describe '.load' do
    it 'reads and creates a new file instance' do
      expect(file).to be_a(I18nJsFile)
      expect(file.attributes['locales']).to eq(%w(en es))
    end
  end

  describe '#only' do
    it 'retrieves the only filter' do
      expect(file.only).to eq('*.my_app.*')
    end
  end

  describe '#locales' do
    it 'retrieves the list of locales' do
      expect(file.locales).to eq(%w(en es))
    end
  end

  describe '#overwrite' do
    it 'replaces attributes and returns a new instance' do
      new_file = file.overwrite('locales' => %w(ko ja))
      expect(new_file.locales).to eq(%w(ko ja))
    end
  end

  describe '#write' do
    it 'serializes and writes the contents to the given path' do
      # store the file in the asset path, which gets destroyed before
      # every test
      FileUtils.mkdir_p(asset_path)
      path = asset_path.join('test.i18njs').to_s
      file.write(path)
      expect(File.read(path)).to eq(contents)
    end
  end

  describe '#dump' do
    it 'serializes the file contents' do
      expect(file.dump).to eq(contents)
    end
  end
end
