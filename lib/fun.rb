# encoding: UTF-8
require 'colorize'
require 'json'
require "net/http"
require 'digest/sha1'
require "base64"
require'httparty'
require 'time'
require 'whois'
module Fun
	class << self
		def domain_exist(domain)
			c = Whois::Client.new
			r = c.whois(domain)
			av = r.available?
			reg = r.registered?
			d = {"available" => av, "registered" => reg}
		end
		def get_pun
			uri = URI.parse('https://getpuns.herokuapp.com/api/random')
            response = Net::HTTP.get_response(uri)
            data = JSON.parse(response.body)
            return data['Pun']
		end
		def geek_jokes
			g = HTTParty.get("https://geek-jokes.sameerkumar.website/api").body
		end
		def yes_or_no
			["yes", "no"].sample
		end
		def cats_facts
			res = HTTParty.get("https://catfact.ninja/fact")
            data = JSON.parse(res.body)
            cat = data["fact"]
		end
		def ron_swanson
			response = HTTParty.get("https://ron-swanson-quotes.herokuapp.com/v2/quotes")
            info = response.to_s.gsub("[", "").gsub("]", "")
		end
		def sys32(user, sender)
			"#{sender} deletes #{user}'s system32"
		end
		def ddos_user(user, sender)
			"#{sender} ddoses #{user}"
		end
		def stab_user(user, sender)
			":knife: #{sender} stabs #{user} :knife:"
		end
		def beer_user(user)
			"🍺 hands #{user} a cold beer 🍺" 
		end
		def give_cookie(user)
			"Gives #{user} a cookie"
		end
		
	end
end
