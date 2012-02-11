require "helper"

class GameTest < Test::Unit::TestCase
  
  def setup
    @game = Game.create
    @player_a = Player.create(full_name: "Sean Behan")
    @player_b = Player.create(full_name: "Pete Land")
  end
  
  def test_game_player_associations
    assert @game.challenger = @player_a
    assert @game.challengee = @player_b
    assert @game.winner = @player_a
    assert @game.loser = @player_b
  end

  def test_find_the_winner
    @game.challenger = @player_a
    @game.challengee = @player_b
    
    @game.challenger_score = 21
    @game.challengee_score = 19
    
    assert_equal @player_a, @game.find_the_winner
  end

  def test_find_the_loser
    @game.challenger = @player_a
    @game.challengee = @player_b
    
    @game.challenger_score = 21
    @game.challengee_score = 19
    
    assert_equal @player_b, @game.find_the_loser
  end
  
  def test_a_tie_game
    @game.challenger = @player_a
    @game.challengee = @player_b
    assert_equal true, @game.its_a_tie!
  end
end
