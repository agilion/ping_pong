require "helper"

class PlayerTest < Test::Unit::TestCase
  def setup
    @player_a = Player.find_or_create_by_full_name(:full_name => "Sean Behan")
    @player_b = Player.find_or_create_by_full_name(:full_name => "Pete Land")
    @player_c = Player.find_or_create_by_full_name(full_name: "Tom McDaniel")
  end

  def test_player_game_associations
    assert @player_a.games.build
    assert @player_a.challenges.build
    assert @player_a.wins.build
    assert @player_a.losses.build
  end

  def test_player_challenges_another_player
    @game = @player_a.challenge!(@player_b)
    assert_equal @game, Game.find_by_challenger_id(@player_a.id)
    assert_equal @game, Game.find_by_challengee_id(@player_b.id)
  end

  def test_player_accepts_a_challenge
    @game = @player_a.challenge!(@player_b)
    assert_equal false, @game.accepted?
    @player_b.accept_challenge!(@game)
    assert_equal true, Game.find_by_challengee_id(@player_b.id).accepted?
  end

  def test_player_wins_a_game
    @game = @player_a.challenge!(@player_b)
    @player_b.accept_challenge!(@game)

    @game.challenger_score = 21
    @game.challengee_score = 19
    @game.finalize!

    assert_equal @player_a, @game.winner
    assert_equal @player_b, @game.loser
  end

end