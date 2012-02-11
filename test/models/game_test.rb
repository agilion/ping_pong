require "helper"

class GameTest < Test::Unit::TestCase
  
  def test_games
    assert Game.create
    assert_equal 1, Game.count
  end
  
end
