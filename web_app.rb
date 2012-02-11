
class WebApp < Sinatra::Base
  # Homepage
  get '/' do
    'Hello World'
  end

  # Show page for a player *Needs cool stats and competitive language!*
  get '/players/:id' do
  end
  
  # An elaboration of the homepage but with all time statistics (Total num wins/losses, Greatest player on the platform ever)
  get '/leaderboard' do
  end

  # Create a new challenge
  post '/games' do
  end
  
  # Update score
  put '/games/:id' do
  end
  
  # Remove an old game or challenge
  delete '/games/:id' do
  end
end