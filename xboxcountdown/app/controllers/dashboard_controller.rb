class DashboardController < ApplicationController
	def index
		@sidebarSelected = "dashboard"
		render 'index'
	end

	def games
		if params["s"] == "" or params["s"] == nil then 
			@games = Game.all.where(:state => "active").paginate(:page => params[:page], :per_page => 20).order(release_date: :desc)
		else
			query = params["s"]
			@games = Game.all.where("title like ? AND state = ?", "%#{query}%", "active").paginate(:page => params[:page], :per_page => 20).order(release_date: :desc)
		end
		@sidebarSelected = "view_games"
		render 'games'
	end

	def addGame
		@sidebarSelected = "add_game"
		render 'add_game'
	end

	def createGame
		game = Game.new
		game.title = params["title"]
		game.console = params["console"]
		game.release_date = params["releasedate"].to_datetime
		game.image = params["image"]
		game.state = "queue"
		game.save
		redirect_to action: 'addGame'
	end

	def viewGame
		@game = Game.find(params[:id])
		@sidebarSelected = "game_queue"
		render 'view_game'
	end

	def editGame
		@game = Game.find(params[:id])
		@sidebarSelected = "view_games"
		render 'edit_game'
	end

	def saveGame
		game = GameEdit.new
		game.game_id = params[:id]
		game.title = params["title"]
		game.console = params["console"]
		game.release_date = params["releasedate"].to_datetime
		unless params["image"] == "" then game.image = params["image"] 
		else game.image = Game.find(params[:id]).image end
		game.state = "queue"
		game.save
		redirect_to action: 'games'
	end

	def gameQueue
		@games = GameEdit.all.where("state = 'queue'").order(created_at: :asc)
		@sidebarSelected = "game_queue"
		render 'game_queue'
	end

	def gameAccept
		game = Game.find(params[:id])
		game.state = "active"
		game.save
		redirect_to action: 'gameQueue'
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
end
