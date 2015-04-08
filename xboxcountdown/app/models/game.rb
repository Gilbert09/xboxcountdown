class Game < ActiveRecord::Base
	belongs_to :publisher, inverse_of: :games
	before_create :randomize_file_name

	has_attached_file :image, 
					  :styles => { :medium => "290x200>", :thumb => "90x67>" },
					  :default_url => "/images/:style/missing.png",
					  :url => '/images/:style/:basename.:extension'
  	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  	private
		def randomize_file_name
	    	extension = File.extname(image_file_name).downcase
	    	self.image.instance_write(:file_name, "#{SecureRandom.hex(16)}#{extension}")
	  	end
end
