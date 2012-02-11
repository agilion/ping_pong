$:.unshift File.expand_path(File.dirname(__FILE__))

require 'rubygems'
require 'rake'
require 'sinatra'
require 'ping_pong'
require 'sinatra/activerecord/rake'

task :default => :test

require 'rake/testtask'

Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end
