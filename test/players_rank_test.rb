require "helper"

class PlayersRankTest < Test::Unit::TestCase
  def setup
    @player_a = Player.find_or_create_by_full_name(:full_name => "Sean Behan")
    @player_b = Player.find_or_create_by_full_name(:full_name => "Pete Land")
    @player_c = Player.find_or_create_by_full_name(full_name: "Tom McDaniel")
  end

  def test_calculate_player_rank
    10.times do
      # Sean beats Pete 10 times by 2
      Game.create(:challenger => @player_a, :challengee => @player_b, :challenger_score => 21, :challengee_score => 19, :winner => @player_a, :loser => @player_b, :completed_at => Time.now)
      # Sean beats Tom 10 times by 6
      Game.create(:challenger => @player_a, :challengee => @player_c, :challenger_score => 21, :challengee_score => 15, :winner => @player_a, :loser => @player_c, :completed_at => Time.now)
      # Pete beats Tom 10 times by 4
      Game.create(:challenger => @player_b, :challengee => @player_c, :challenger_score => 21, :challengee_score => 17, :winner => @player_b, :loser => @player_c, :completed_at => Time.now)
    end

    # Pete beats Sean by 4
    5.times do
      Game.create(:challenger => @player_b, :challengee => @player_a, :challenger_score => 21, :challengee_score => 18, :winner => @player_b, :loser => @player_a, :completed_at => Time.now)
    end

    3.times do
      # Tom beats Pete by 3
      Game.create(:challenger => @player_c, :challengee => @player_b, :challenger_score => 21, :challengee_score => 18, :winner => @player_c, :loser => @player_b, :completed_at => Time.now)
      # Tom beats Sean by 1
      Game.create(:challenger => @player_c, :challengee => @player_a, :challenger_score => 21, :challengee_score => 20, :winner => @player_c, :loser => @player_a, :completed_at => Time.now)
    end

    Player.rank_players!

    # Sean, Pete, Tom
    assert_equal @player_a, Player.by_rank.first
    assert_equal @player_b, Player.by_rank.second
    assert_equal @player_c, Player.by_rank.third

    puts %W(Pong_Player Wins Losses Rank).join("\t")
    %W(first second third).each do |place|
      puts [Player.by_rank.send(place).full_name, Player.by_rank.send(place).wins.count, Player.by_rank.send(place).losses.count, Player.by_rank.send(place).rank].join("\t")
    end
  end
end