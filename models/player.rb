class Player < ActiveRecord::Base
  GRAVITY = 1.8

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
    # Python implementation of Gravity Algorithm
    # http://amix.dk/blog/post/19574
    # (wins.count - 1) / pow((wins.last.completed_at.hour + 2), GRAVITY) if wins.any?
    # 
    # (10 - 1) / ((12 - 2)**1.8)
    #    
    player_rank = if wins.empty?
      0.0
    else
      (wins.count - 1) / ((wins.last.completed_at.hour + 2)**GRAVITY)
    end
    update_attribute(:rank, player_rank)
  end
  
  def self.rank_players!
    Player.all.each do |player|
      player.calculate_rank!
    end
  end
end