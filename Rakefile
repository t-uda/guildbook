require 'rubygems'
require 'bundler/setup'
require 'sinatra/asset_pipeline/task'
require "#{File.dirname(__FILE__)}/lib/app"
require 'rake/testtask'

Sinatra::AssetPipeline::Task.define! GuildBook::App

desc 'Run unit test'
Rake::TestTask.new do |task|
  # To run a certain test
  #     $ bundle exec rake test TEST=path/to/test.rb
  task.libs << 'test'
  task.test_files = Dir['test/**/*.rb']
  task.verbose = true
end
