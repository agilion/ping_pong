class CreatePlayers < ActiveRecord::Migration
  def self.up
    create_table :players do |t|
      t.string :full_name
      t.string :screen_name
    end
  end

  def self.down
    drop_table :players
  end
end
