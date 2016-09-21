# encoding: UTF-8

$:.unshift File.join(File.dirname(__FILE__), 'lib')

require 'rubygems' unless ENV['NO_RUBYGEMS']

require 'bundler'
require 'pry-byebug'
require 'rspec/core/rake_task'
require 'rubygems/package_task'

require 'rails'
require 'sprockets/railtie'
require 'i18n-js-assets'

Bundler::GemHelper.install_tasks

task :default => :spec

desc 'Run specs'
RSpec::Core::RakeTask.new do |t|
  t.pattern = './spec/**/*_spec.rb'
end

# for dummy app
Dir.chdir('spec') do
  require File.expand_path('../spec/config/application', __FILE__)
  I18nJsAssets::DummyApplication.initialize!
  I18nJsAssets::DummyApplication.load_tasks
end
