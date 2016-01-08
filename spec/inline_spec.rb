# encoding: UTF-8

require 'spec_helper'

describe 'inline' do
  it 'requires javascript translations' do
    asset = Rails.application.assets.find_asset('application.js')
    expect(unescape_unicode(asset.source)).to include(en_source)
    expect(unescape_unicode(asset.source)).to include(es_source)
  end

  it 'only includes translations for the requested locales' do
    asset = Rails.application.assets.find_asset('translations/language_specific.js')
    expect(unescape_unicode(asset.source)).to_not include(en_source)
    expect(unescape_unicode(asset.source)).to include(es_source)
  end
end
