class CreateGames < ActiveRecord::Migration
  def self.up
    create_table :games do |t|
      t.integer :player_one_id
      t.integer :player_two_id
      t.integer :player_one_score
      t.integer :player_two_score
      t.boolean :player_one_wins
      t.boolean :player_two_wins
    end
  end

  def self.down
    drop_table :games
  end
end
