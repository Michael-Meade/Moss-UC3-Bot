require 'json'
require 'rss'
<<<<<<< HEAD
require 'open-uri'
require 'rss'
require 'open-uri'
=======
>>>>>>> 6c8790b744e3119150b90820a7700ef4e34acc99
require_relative 'plugin'
class String
  def numeric?
    Float(self) != nil rescue false
  end
end
class News
	Plugin::Files.create_dir("news")

	def self.read_list
		Plugin::Files.file_check("news/sites.json")
		list = File.read("news/sites.json")
		JSON.parse(list)
	end
<<<<<<< HEAD
	def self.events
		doc = Nokogiri::HTML(open("https://pioneerplace.utica.edu/events.rss"))
		aa = ""
		url = 'https://pioneerplace.utica.edu/events.rss'
		open(url) do |rss|
			feed = RSS::Parser.parse(rss)
			puts "Title: #{feed.channel.title}"
			feed.items.each do |item|
				document = Nokogiri::HTML(item.description)
				
				aa += "**#{item.title}**" + "\n" + document.at('time').text + "\n"
			end
			return aa
		end
	end
=======
>>>>>>> 6c8790b744e3119150b90820a7700ef4e34acc99
	def self.create_list
		i    = 0
		list = ""
		read_list.each do |key, values|
			list += "#{key}] #{values}\n"
		end
		return list
	end
	def self.add_site(site)
		read  = File.read("news/sites.json")
		read2 = JSON.parse(read).keys.last.to_i
		Plugin::Files.add_custom("news/sites.json", read2 += 1, site)
	end
	def self.get_news(id)
		site = get_url(id)
		i = 0
		puts site
	    rss = open(site.to_s)
	    feed = RSS::Parser.parse(rss)
	    feed.items.each do |item|
	      until i == "1"
	        i +=1
	        return {"Title" => item.title, "Link" => item.link, "Description" => item.description}
	        exit
	      end
	    end
	end
	def self.get_url(id)
		i = 0
		read_list.each do |key, value|
			if key == id.to_s
				return value
			end
		end 
	end
end


#News.create_list
#puts News.get_url("1")
#puts News.add_site("pornthub.com")
#puts News.get_news(1)