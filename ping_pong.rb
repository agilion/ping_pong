$:.unshift File.expand_path(File.dirname(__FILE__))

require "yaml"

ENV["RACK_ENV"] = ENV["RACK_ENV"] || "development"

environment = YAML.load_file("config/database.yml")[ENV["RACK_ENV"]]

require "sinatra"
require "sinatra/reloader"
require "sinatra/activerecord"

set :database, environment["database"]

ActiveRecord::Base.logger = Logger.new File.open("log/#{ENV['RACK_ENV']}.log", 'a')

require "models/player"
require "models/game"

also_reload 'models/player'
also_reload 'models/game'

require "web_app"
