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
    assert last_response.ok?    
  end
  
  def test_leaderboard
    get '/leaderboard'
    assert last_response.ok?
  end
  
  def test_player_profiles
    get '/players/1'
    assert last_response.ok?
  end
  
  def test_create_a_new_challenge
    post '/games'
    assert last_response.ok?
  end
  
  def test_updating_score_and_declaring_victory
    put '/games/1'
    assert last_response.ok?    
  end
  
  def test_removing_a_challenge_or_game_from_the_platform
    delete '/games/1'
    assert last_response.ok?
  end
end