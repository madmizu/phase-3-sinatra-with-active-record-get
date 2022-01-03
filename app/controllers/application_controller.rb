class ApplicationController < Sinatra::Base

  set :default_content_type, 'application/json'
  get '/' do
    { message: "Hello world" }.to_json
  end

  get '/games' do
    # get all the games from the database
      # games = Game.all
    # to sort by game title
      # games = Game.all.order(:title)
    # to return the first 10 games
      games = Game.all.order(:title).limit(10) 
    # return a JSON response with an array of all the game data
      games.to_json
  end

  # use the :id syntax to create a dynamic route
  get '/games/:id' do
    # look up the game in the database using its ID
      game = Game.find(params[:id])
    # send a JSON-formatted response of the game data
    # include associated info, and many through info:
      # game.to_json(include: {reviews: { include: :user} })
    game.to_json(only: [:id, :title, :genre, :price], include: {
      reviews: {only: [:comment, :score], include: {
        user: {only: [:name] }
      } }
    })
  end

end
