require_relative  '../utils'
require 'fileutils'
require 'base64'
require 'json'
require 'random-word'
require_relative '../encode'
class CTF_Crypto
	def self.dir(uid)
		"answers/" + uid.to_s + ".json"
	end
	def self.generate_xor(uid)
		FileUtils.mkdir_p "answers"  unless File.exists?("answers")
		key = rand(100..999)
		str = ('a'..'z').to_a.sample(10).join
		xor = str.split(//).collect {|e| [e.unpack('C').first ^ (key.to_i & 0xFF)].pack('C') }.join
		if not File.exists?("answers/" + uid.to_s + ".json")
			f = File.open("answers/"  + uid.to_s + ".json", "a")
			x = {"xor" => Base64.encode64(xor), "answers" => str}
			f << JSON.pretty_generate(x)
			f.close
		else 
			read = File.read("answers/" + uid.to_s + ".json")
			a = JSON.parse(read)
			a["xor"] = Base64.encode64(xor)
			a["answers"] = str
			f = File.open(self.dir(uid), "w")
			f << JSON.pretty_generate(a)
			f.close
		end
		{"Key" =>  Base64.encode64(xor)}
	end

	def self.pick_lyrics
		File.readlines("movie-quotes.txt").sample.gsub('"', "")
	end
	def self.create_json(uid)
		File.exists?("answers/" + uid.to_s + ".json")
	end
	def self.ceaserEasy(uid)
		pick = self.pick_lyrics
		code = Encode.caesar_cipher(pick, shift = 1)
		puts pick
		if not create_json(uid)
			f = File.open("answers/"  + uid.to_s + ".json", "a")
			f << JSON.pretty_generate({"ceaser" => pick})
			f.close
		else
			read = File.read("answers/" + uid.to_s + ".json")
			a = JSON.parse(read)
			a["ceaser"] = pick
			p a
			f = File.open("answers/" + uid.to_s + ".json", "w")
			f << JSON.pretty_generate(a)
			f.close
		end
		{"ceaser" => code.join}
	end
	def self.check_xor(uid, check)
		read = File.read("answers/" + uid.to_s + ".json")
		json = JSON.parse(read)
		if json["answers"] == check
			return true
		else
			return false
		end
	end
end

##CTF_Crypto.generate_xor("1")