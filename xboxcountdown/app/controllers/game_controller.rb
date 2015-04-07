class GameController < ApplicationController
	def index
		render 'index'
	end

	def get
		@game = Game.get(game_params)
		render 'get'
	end

	private
		def game_params
			params.require(:game).permit(:id)
		end
end
