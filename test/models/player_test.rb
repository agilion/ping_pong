require "helper"

class PlayerTest < Test::Unit::TestCase
  
  def test_players
    assert Player.create
    assert_equal 1, Player.count
  end
  
end
