class Game < ActiveRecord::Base
  belongs_to :challenger, class_name: "Player", foreign_key: "challenger_id"
  belongs_to :challengee, class_name: "Player", foreign_key: "challengee_id"
  belongs_to :winner, class_name: "Player", foreign_key: "winner_id"
  belongs_to :loser, class_name: "Player", foreign_key: "loser_id"

  def finalize!
    self.winner = find_the_winner
    self.loser  = find_the_loser
    self.winner_score = find_winners_score
    self.loser_score = find_losers_score
    self.completed = true
    self.completed_at = Time.now
    # Player.rank_players!
    save
  end

  def find_the_winner
    return nil if its_a_tie!

    challenger_score > challengee_score ? challenger : challengee
  end

  def find_the_loser
    return nil if its_a_tie!

    challenger_score < challengee_score ? challenger : challengee
  end

  def find_winners_score
    winner == challenger ? challenger_score : challengee_score
  end

  def find_losers_score
    winner == challenger ? challengee_score : challenger_score
  end

  def its_a_tie!
    challenger_score == challengee_score
  end

  def to_s
    "#{winner}"
  end
end