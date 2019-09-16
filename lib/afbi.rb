require 'httparty'
require 'json'
require "net/http"
require 'resolv-replace'
require 'uri'
class Afbi
	def self.get_image(count)
		c = HTTParty.get("http://theafbi.com:4567/afbi/#{count}").body
		puts c["Links"]
	end
	def self.optOut
		puts
	end
	def self.afbi
		c = HTTParty.get("http://theafbi.com:4567/afbi/0")
		c.parsed_response["Links"].shift
		#uri = URI.parse("http://theafbi.com:4567/afbi/1")
        #response   = Net::HTTP.get_response(uri)
        #puts response.body
        #dafbi = JSON.parse(response.body)["Links"][0]
	end
	def self.dafbi
		#response = HTTParty.get("http://theafbi.com:4567/dafbi/1")
		#return JSON.parse(response.body)["Links"][0]
		uri = URI.parse("http://theafbi.com:4567/dafbi/1")
        response   = Net::HTTP.get_response(uri)
        puts response
        dafbi = JSON.parse(response.body)["Links"][0]
	end
	def self.unOptOut
		puts
	end
end
