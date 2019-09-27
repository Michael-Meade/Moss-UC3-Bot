class Memes
	def initialize(id)
		@id = id
    end
    def get_file
    	sorts = Dir.glob("memes/*").sort
    	count = 0
    	while count < sorts.length
    		if count.to_i == @id.to_i
                return sorts[count]
    		end
            count +=1
    	end
    end
    def add_image(input)
        begin
            file = self.get_file
            f = File.open(file, "a")
            f << input
            f << "\n"
            f.close
            error = {"Status" => "Successfully added link to #{file}"}
        rescue => e
            puts e
            error = {"Status" => "Failed to add link to #{file}"}
        end
    end
    def list_dir
    	sorts = Dir.glob("memes/*").sort
    end
    def pick_random
    	choosen = Dir.glob("memes/*").sample
    	File.readlines(choosen).sample
    end
    def sunny
    	sunny = File.readlines("memes/sunny.txt").sample
    end
    def office
    	office = File.readlines("memes/office.txt").sample
    end
    def family_guy
    	family =  File.readlines("memes/family_guy.txt").sample
    end
    def community
        community = File.readlines("memes/community.txt").sample
    end
    def easy_pic
        begin
            easy = File.readlines("memes/#{@id}.txt").sample
        rescue => e
            #s = {"Status" => "Dir doesnt Exist."}
            puts
        end
    end
    def pepe
    	pepe = File.readlines("memes/pepe.txt").sample
    end
    def no_you
    	no = File.readlines("memes/no_you.txt").sample
    end
end
module Meme
	class << self
		def dir_list
			a = Memes.new("1").list_dir
			array = ""
			count = 0
			a.each do |b|
				array += count.to_s + "] " + b.to_s + "\n"
				count += 1
			end
			array
		end
		def pepe
			Memes.new("1").pepe
		end
        def random
            Memes.new("1").pick_random
        end
		def no_you
			Memes.new("1").no_you
		end
        def pic_easy(id)
            a = Memes.new(id)
            a.easy_pic
        end
		def get_file(id, link)
			m = Memes.new(id)
            puts link
			names = m.add_image(link)
		end
	end
end
#Meme.get_file("1", "pornhub.com")