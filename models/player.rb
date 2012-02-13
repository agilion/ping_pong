class Player < ActiveRecord::Base
  GRAVITY = 1.8

  scope :by_rank, order('rank DESC')

  has_many :games, foreign_key: 'challenger_id'
  has_many :challenges, foreign_key: 'challengee_id', class_name: "Game"
  has_many :wins, foreign_key: 'winner_id', class_name: "Game"
  has_many :losses, foreign_key: 'loser_id', class_name: "Game"

  def challenge!(player)
    Game.create(challenger: self, challengee: player)
  end

  def accept_challenge!(game)
    challenges.find(game).update_attributes(accepted: true, accepted_at: Time.now)
  end

  def calculate_rank!
    # Based on a Python implementation of Gravity Algorithm used to rank "Hotness" of Hacker News Articles. http://amix.dk/blog/post/19574
    #
    # rank =
    #
    # wins
    # losses
    # total points from wins
    # total points from losses
    # total points
    # frequency of game play (ie total number of games played)
    #
    player_rank = if wins.empty?
      0.0
    else
      (wins.count - 1) / ((wins.last.completed_at.hour + 2)**GRAVITY)
    end
    update_attribute(:rank, player_rank)
  end

  # Rerank all players (trigger when a new game has been finalized)
  def self.rank_players!
    Player.all.each do |player|
      player.calculate_rank!
    end
  end

  def to_s
    full_name
  end
end