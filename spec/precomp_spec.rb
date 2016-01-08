# encoding: UTF-8

require 'spec_helper'

describe 'precompilation' do
  it 'precompiles correctly' do
    assets_config.localized.add(
      "translations/precompilable.js", "translations/precompilable-%{locale}.js",
      precompile: %w(en es)
    )

    # generated.apply! will trigger localized.apply! via before hook
    assets_config.generated.apply!

    begin
      # this is for Rails 3
      Rake::Task['assets:precompile:primary'].invoke
      Rake::Task['assets:precompile:nondigest'].invoke
    rescue RuntimeError
      # this is for Rails 4
      Rake::Task['assets:precompile'].invoke
    end

    rails_manifest = GeneratedAssets::RailsManifest.load_for(app)

    digest_file = rails_manifest.find_by_logical('translations/precompilable-en.js')
    expect(digest_file).to_not be_nil
    contents = unescape_unicode(asset_path.join(digest_file).read)
    expect(contents).to include(en_source)
    expect(contents).to_not include(es_source)

    digest_file = rails_manifest.find_by_logical('translations/precompilable-es.js')
    expect(digest_file).to_not be_nil
    contents = unescape_unicode(asset_path.join(digest_file).read)
    expect(contents).to include(es_source)
    expect(contents).to_not include(en_source)
  end
end
