class PublisherController < ApplicationController
	def index
		render 'index'
	end

	def get
		@publisher = Publisher.get(publisher_params)
		render 'get'
	end

	private
		def publisher_params
			params.require(:publisher).require(:id)
		end
end
