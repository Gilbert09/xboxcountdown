class DashboardController < ApplicationController
	def index
		@sidebarSelected = "dashboard"
		render 'index'
	end

	def games
		@games = Game.all.order(release_date: :desc)
		@sidebarSelected = "view_games"
		render 'games'
	end

	def addGame
		@sidebarSelected = "add_game"
		render 'add_game'
	end

	def createGame
		throw
	end

	def import
		page_string = ""
		open('http://xboxcountdown.com/upcoming_games.json') do |f|
			page_string = f.read
		end
		json = JSON.parse(page_string)
		json.each do |game|
			g = Game.new
			g.title = game["Title"]
			g.release_date = game["Date"].to_datetime
			g.console = game["Console"]
			g.image = open('http://xboxcountdown.com/img/' + game["Img"])
			g.save
		end
		render :json => Game.all
	end

	def edit
		render :html => params[:id]
	end
end
