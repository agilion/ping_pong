$:.unshift File.dirname(__FILE__) + "/../"

require 'ping_pong'

@sean = Player.find_or_create_by_full_name("Sean Behan")
@pete = Player.find_or_create_by_full_name("Pete Land")
@tom  = Player.find_or_create_by_full_name("Tom McDaniel")

@game = Game.create(challenger: @sean, challengee: @pete, challenger_score: 21, challengee_score: 19)
@game.finalize!


Player.rank_players!