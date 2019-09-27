require 'fileutils'
require 'json'
require 'random-word'
require 'fileutils'
require 'securerandom'
require 'base64'
require_relative 'crypto'
require "open3"
class GenerateGPG < CTF_Crypto
	FileUtils.mkdir_p "flags/"  unless File.exists?("flags/")
	FileUtils.mkdir_p "template/"  unless File.exists?("template/")
	def self.generate_flag
		flag = pick_lyrics
		FileUtils.mkdir_p "flags/"  unless File.exists?("flags/")
		random = SecureRandom.hex
		f = File.open("flags/#{random}.json", "a")
		f.write(JSON.pretty_generate({"flag"   => flag}))
		f.close
		system("cp flags/#{random}.json template/ReadMe.txt")
		flag
	end
	def self.generate_json(filename, h)
		f = File.new(filename.to_s, "w")
		f.write(JSON.pretty_generate(h))
		f.close
	end
	def self.create_gpg
		system('gpg --encrypt  --armor -r password template/ReadMe.txt')
		FileUtils.rm("template/ReadMe.txt")
		Open3.popen3("zip -r secret.zip template/")
		sleep 3.0
		#exec("cat image.jpeg secret.zip > secret.png")
		Open3.popen3('cat image.jpeg secret.zip > secret.png') { |stdin, stdout, stderr| }
	end
	def self.clean_up
		system("rm template/ReadMe.txt")
	end
end

GenerateGPG.generate_flag
GenerateGPG.create_gpg