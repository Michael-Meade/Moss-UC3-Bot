require 'Fileutils'
require 'json'
class DefCon
	def initialize(link)
		@link = link
		FileUtils.mkdir_p "def_con/"  unless File.exists?("def_con/")
    end
    def add_link(title)
    	key = @link.match(/(?:youtube(?:-nocookie)?\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=)|youtu\.be\/)([a-zA-Z0-9_-]{11})/)[1]
    	f = File.open("def_con/#{key}.json", "a")
    	f.write(JSON.pretty_generate({"Link"   => @link, "Title" => title}))
    end
end
module Def_Con
	class << self
		def add_link(title, link)
			dc = DefCon.new(link)
			dc.add_link(title)
		end
	end
end

Def_Con.add_link("HI", "https://www.youtube.com/watch?v=WHbVmzhglu0")
