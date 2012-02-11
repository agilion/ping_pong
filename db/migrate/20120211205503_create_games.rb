class CreateGames < ActiveRecord::Migration
  def self.up
    create_table :games do |t|
      t.integer :challenger_id
      t.integer :challengee_id
      t.integer :winner_id
      t.integer :loser_id
      t.integer :challenger_score
      t.integer :challengee_score
      t.boolean :completed
      t.boolean :accepted
      t.timestamp :accepted_at
      t.timestamp :completed_at
      t.timestamps
    end
  end

  def self.down
    drop_table :games
  end
end
