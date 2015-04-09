class ApiController < ApplicationController

	def index
		gameArray = Array.new
		Game.all.where("state = 'active'").each do |game|
			gameArray.push({ :Title => game.title, :Date => game.release_date.strftime('%d/%m/%Y'), :Console => game.console, :Img => game.image.url(:medium) })
		end
		render json: gameArray
	end

	def game
		
	end

	def publisher
		
	end
end
