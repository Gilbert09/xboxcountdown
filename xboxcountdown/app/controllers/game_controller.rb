class GameController < ApplicationController
	def index
		@games = Game.all
		render 'index'
	end

	def get
		@game = Game.find(params["id"])
		render 'get'
	end

	def create
		game = Game.new
		game.title = params["title"]
		game.console = params["console"]
		game.release_date = params["releasedate"].to_datetime
		game.image = params["image"]
		game.save
		redirect_to action: 'get', id: game.id
	end
end
