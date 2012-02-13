
class WebApp < Sinatra::Base
  # Homepage
  get '/' do
    @games = Game.all
    erb :index
  end

  # Show page for a player *Needs cool stats and competitive language!*
  get '/players/:id' do
    erb :'players/show'
  end

  # An elaboration of the homepage but with all time statistics (Total num wins/losses, Greatest player on the platform ever)
  get '/leaderboard' do
    erb :leaderboard
  end

  # Create a new challenge
  post '/games' do
    erb :'games/index'
  end

  # Update score
  put '/games/:id' do
    erb :'games/show'
  end

  # Remove an old game or challenge
  delete '/games/:id' do
  end
end