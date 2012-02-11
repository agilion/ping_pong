class Player < ActiveRecord::Base
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
end