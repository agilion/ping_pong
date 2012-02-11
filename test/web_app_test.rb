require "helper"
require 'rack/test'

class WebAppTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    WebApp
  end

  def test_index
    get '/'
    assert_equal 'Hello World', last_response.body
  end
  
end