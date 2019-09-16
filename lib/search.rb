require 'httparty'
require 'json'
require "net/http"
require 'uri'
require "resolv"
require 'youtube_search_v3'
require 'wikipedia'
class Search
	def initialize(q)
		@q = q
    end
    def youtube(value=nil)
    	begin
    		if value.nil?
    			value = 0
    		end
    		g = HTTParty.get("https://www.googleapis.com/youtube/v3/search?part=snippet&key=AIzaSyCCB4q5YuxILXTc8o_anxgjpibeAATUg70&q=#{@q}").body
    		ids = JSON.parse(g)['items'][rand(1..5)]['id']["videoId"]
    		if ids.nil?
    			ids = JSON.parse(g)['items'][rand(1..5)]['id']["videoId"]
    		end
    		"https://www.youtube.com/watch?v=#{ids}".to_s
    	rescue => e
    		puts e
    	end
    end
    def whois
    	response = HTTParty.get "https://jsonwhois.p.rapidapi.com/api/v1/screenshot?domain=google.com",
		  headers:{
		    "X-RapidAPI-Host" => "jsonwhois.p.rapidapi.com",
		    "X-RapidAPI-Key" => "a3ae459847mshb01f36e85b98628p1a3110jsn1b131c1ecb5e",
		    "Authorization" => "Token token=example_T3bhPARa6ek2IxQdgwTcWC9bOEsKEqYdpSwd"
		  }
		  puts response.body
    end
    def lookup_cyber
		uri        = URI.parse("https://cyberpolicy.com/api/v1/glossary_terms/" + @q.strip)
        response   = Net::HTTP.get_response(uri)
        data       =  JSON.parse(response.body)
        definition =  data['results'][0]['definition'].to_s
        term       =  data['results'][0]['term'].to_s
        dict = {"def" => definition, "term" => @q}
    end
    def ip_lookup
    	a = HTTParty.get("https://api.ipgeolocation.io/ipgeo?apiKey=9ab2c58fd9ac4c09b1b98a813b5c5338&ip=#{@q}&lang=en")
    	JSON.parse(a.body)
    end
    def urban_dict(value=0)
		url = "http://api.urbandictionary.com/v0/define?term=#{@q}"
        uri = URI.parse(url)                      
        response = Net::HTTP.get_response(uri)
        data = JSON.parse(response.body)["list"][value.to_i]["definition"]
	end
	def self.bing_search
	end
	def wikia_search
		page = Wikipedia.find(@q)
		dict = {"wikia" => page.fullurl + "\n" + page.summary}
	end
	def get_weather
		response = HTTParty.get("https://api.openweathermap.org/data/2.5/weather?zip=" + @q + ",us&appid=3e029d9d2895ddf14349dbaf24cc0851&units=imperial")
        id =  response.parsed_response
        if id["cod"] == "404"
        	"Zip code doesnt exist"
        else
            string = "***Main:*** #{id['weather'][0]['main']} \n ***Description:*** #{id['weather'][0]['description']} \n ***Temp:*** #{id['main']['temp']} \n ***Humidity:*** #{id['main']['humidity']} \n ***Temp Min:*** #{id['main']['temp_min']} \n ***Temp Max:*** #{id['main']['temp_max']}"
        end
	end
	def yify_search
		a = HTTParty.get("https://yts.am/api/v2/list_movies.json?query_term=#{@q}").parsed_response["data"]["movies"].to_json
		puts a['title'].to_s
		s = {"Title"   => a["title"],
		     "Year"    => a['year'],
		     "Rating"  => a['rating'],
		     "RunTime" => a['runtime'],
		     "Genre"   => a["genres"],
		     "Summary" => a['summary'],
		     "pic"     => a['large_cover_image'],
		 	 "Torrent" => a['url'],
		 	 "Quality" => a['quality'],
		 	 "Seeds"   => a['seeds'],
		 	 "Peers"   => a['peers'],
		 	 "Size"    => a['size']}
	end
	def honeypot_username
		a = HTTParty.get("http://theafbi.com:4567/username", verify:true, timeout: 60)
		a.parsed_response
	end
	def get_domain
		Resolv.getname @q.to_s
	end
	def domain_ip
		s = Resolv.getaddress @q.to_s
	end
	def open_moviedb
		req = HTTParty.get("http://www.omdbapi.com/?t=#{@q}&apikey=24102450")
		json = JSON.parse(req.body)
		puts json
		dict = {"Movie" => json["Title"] + "\n" + json["Year"] + "\n" + json["Runtime"] + "• " + json["imdbRating"] + "\n\n" + json["Plot"] + "\n\n\n" + json["Genre"]}
	end
	def tenor_gif_search
		g = HTTParty.get("https://api.tenor.com/v1/search?q=#{@q}&key=LIVDSRZULELA").body
		jsonParse = JSON.parse(g)
		jsonParse["results"][0]["url"].to_s
	end
end
module Searching
	class << self
		def youtube(q, value=nil)
			s = Search.new(q)
			s.youtube(value)
		end
		def gif_search(q)
			s = Search.new(q)
			s.tenor_gif_search
		end
		def moviedb(q)
			s = Search.new(q)
			s.open_moviedb
		end
		def yify(q)
			s = Search.new(q)
			s.yify_search
		end
		def weather(q)
			s = Search.new(q)
			s.get_weather
		end
		def username
			s = Search.new("a")
			s.honeypot_username
		end
		def wikia(q)
			s = Search.new(q)
			s.wikia_search
		end
		def urban(q, value=0)
			s = Search.new(q)
			s.urban_dict(value)
		end
		def iplook(q)
			s = Search.new(q)
			s.ip_lookup
		end
		def cyber(q)
			s = Search.new(q)
			s.lookup_cyber
		end
		def pwned(q)
			s = Search.new(q)
			s.hibp
		end
		def who(q)
			s = Search.new(q)
			s.whois
		end
	end
end
#puts Searching.yify("batman")