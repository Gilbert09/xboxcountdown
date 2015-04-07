class Game < ActiveRecord::Base
	belongs_to :publisher, inverse_of: :games
end
