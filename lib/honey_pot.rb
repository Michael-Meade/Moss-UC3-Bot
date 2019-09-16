require_relative 'search'
require 'gruff'
require 'json'
class HoneyPot
	def self.test
		puts Search.honeypot_username
	end
	def self.honeyPot_image
		username  = Search.honeypot_username
		read = JSON.parse(username)
		g = Gruff::Bar.new
		i = 0
		bbb = read.sort_by{|k,v| -v}.first(10).to_h
		aa  = []
		bbb.each do |key, value|
		  aa << [key, value]
		end
		aa.each do |data|
		  g.data(data[0], data[1])
		end
		g.write("pie_one_val.png")
	end
end

#HoneyPot.honeyPot_image
HoneyPot.honeyPot_image