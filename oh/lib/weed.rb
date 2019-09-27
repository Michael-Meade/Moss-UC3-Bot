require 'httparty'
require 'pp'
require 'cgi'
require 'nokogiri'
class Weed
	def initialize(s, num)
		@s = s
		@num = num.to_i
    end
    def get_strain_id
    	g = HTTParty.get("https://cannasos.com/api/search?page=1&search=#{@s.to_s}&type=strain")
    	id = g.parsed_response[@num]
    	h = {"id" => id['_id']}
    end
    def get_strain_info
    	g = HTTParty.get("https://cannasos.com/api/search?page=1&search=#{@s.to_s}&type=strain")
    	strain = g.parsed_response[@num]
    	h = {
    		  "Des" => strain['description'],
    		  "name" =>  strain['title'],
    		  "alias" => strain['alias'],
    		  "sativaPercent" => strain['sativaPercent'],
    		  "indicaPercent" => strain['indicaPercent'],
    		  "typeOfHigh"    => strain['typeOfHigh'],
    		  "orgin"         =>  strain["origin"]
     	}
    end
    def create_info
    	strainId = self.get_strain_id
    	url = "https://render.cannasos.com/api/strain/#{strainId["id"].to_s}/boobs.jpeg?format=jpeg"
    end
end
module Weeds
	class << self
		def get_info(q, num)
			b = Weed.new(q, num)
			b.create_info
		end
		def strain_info(q, num)
			b = Weed.new(q, num)
			b.get_strain_info
		end
	end
end