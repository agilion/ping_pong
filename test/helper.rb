$:.unshift(File.join(File.dirname(__FILE__), ".."))

ENV["RACK_ENV"] = "test"

require "test/unit"

begin
  require 'rubygems'
  require 'turn'
rescue LoadError
end

require "ping_pong"

require 'database_cleaner'
DatabaseCleaner.strategy = :truncation


class Test::Unit::TestCase
  def teardown
    # then, whenever you need to clean the DB
    DatabaseCleaner.clean
  end

  # Make sure that each test case has a teardown
  # method to clear the db after each test.
  def inherited(base)
    base.define_method teardown do
      super
    end
  end
end