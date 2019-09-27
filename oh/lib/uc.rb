require 'rss'
require 'time'
require 'json'
require 'mechanize'
require 'pp'
require 'nokogiri'
require 'fileutils'
def test
	i = 0
	rss = open("https://pioneerplace.utica.edu/events.rss")
	feed = RSS::Parser.parse(rss)
	feed.items.each do |item|
	  until i == "1"
	    i +=1
	    puts item.title
	    puts item.link
	    puts item.description
	    #p {"Title" => item.title, "Link" => item.link, "Description" => item.description}
	    #exit
	  end
	end
end
class UCNEWS
	def self.events
		require 'open-uri'
		doc = Nokogiri::HTML(open("https://pioneerplace.utica.edu/events.rss"))
		require 'rss'
		require 'open-uri'
		aa = ""
		o  = 0
		url = 'https://pioneerplace.utica.edu/events.rss'
		open(url) do |rss|
			feed = RSS::Parser.parse(rss)
			puts "Title: #{feed.channel.title}"
			feed.items.each do |item|
				document = Nokogiri::HTML(item.description)
				
				aa += item.title + ": " + document.at('time').text + "\n"
			end
			#return aa
		end
	end
	def self.rss
		aa = ""
		url = 'http://feeds.feedburner.com/PentestTools?format=xml'
		open(url) do |rss|
			feed = RSS::Parser.parse(rss)
			puts "Title: #{feed.channel.title}"
			feed.items.each do |item|
				p item
			end
			return aa
		end
	end
end

UCNEWS.events
#boobs