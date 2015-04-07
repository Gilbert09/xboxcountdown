class Game < ActiveRecord::Base
	belongs_to :publisher, inverse_of: :games

	has_attached_file :image, :styles => { :medium => "290x200>", :thumb => "90x67>" }, :default_url => "/images/:style/missing.png"
  	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
