require 'json'
require 'random-word'
require 'fileutils'
require 'securerandom'
require 'base64'
require "open3"
class CTF
	def self.run_gpg
		eval File.read("create_gpg/generate-gpg.rb")
		"/lib/ctf/create_gpg/secret.zip"
	end
	def self.generate_flag
		"#{RandomWord.nouns.next + RandomWord.nouns.next}"
	end
	def self.save_flag
		flag = self.generate_flag
		FileUtils.mkdir_p "flags/"  unless File.exists?("flags/")
		f = File.open("flags/#{SecureRandom.hex}.json", "a")
		f.write(JSON.pretty_generate("flag" => flag ))
		f.close
		flag
	end
	def self.generate_xor_key
		random = [1,2,3,4]
		[*('A'..'Z')].sample(random.sample).join
	end
	def self.xor
		result = ""
		string = self.save_flag
		puts string
		key = self.generate_xor_key
		puts key
		code = string.each_codepoint.to_a
		code.each_index do |i|
			result += (code[i] ^ key[i % key.size].ord).chr
		end
		f = File.open("tx.txt", "a")
		f <<  result
	end
end
CTF.xor

#CTF.generate_python

#CTF.generate_gpg
