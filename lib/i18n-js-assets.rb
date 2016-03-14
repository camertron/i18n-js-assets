# encoding: UTF-8

require 'generated-assets'
require 'i18n-js-assets/railtie'
require 'fileutils'
require 'tmpdir'

module I18nJsAssets
  autoload :Entry,      'i18n-js-assets/entry'
  autoload :I18nJsFile, 'i18n-js-assets/i18njs_file'
  autoload :Manifest,   'i18n-js-assets/manifest'
  autoload :Processor,  'i18n-js-assets/processor'
end
