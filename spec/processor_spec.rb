# encoding: UTF-8

require 'spec_helper'

describe I18nJsAssets do
  it 'requires javascript translations' do
    asset = Rails.application.assets.find_asset('application.js')

    expect(unescape_unicode(asset.source)).to include(
      %Q(I18n.translations["en"] = {"my_app":{"teapot":"I'm a little teapot"}};)
    )

    expect(unescape_unicode(asset.source)).to include(
      %Q(I18n.translations["es"] = {"my_app":{"teapot":"Soy una tetera pequeña"}};)
    )
  end
end
