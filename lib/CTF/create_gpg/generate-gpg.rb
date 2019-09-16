require 'fileutils'
require 'json'
require 'random-word'
require 'fileutils'
require 'securerandom'
require 'base64'
require "open3"
def generate_flag
	flag = RandomWord.adjs.next.to_s + rand(1..10000).to_s + RandomWord.adjs.next.to_s
	FileUtils.mkdir_p "flags/"  unless File.exists?("flags/")
	random = SecureRandom.hex
	f = File.open("flags/#{random}.json", "a")
	f.write(JSON.pretty_generate({"flag"   => flag}))
	f.close
	flag
end
def create_read_me
	flag = generate_flag
	f = File.open("template/ReadMe.txt", "w")
	f << flag
	f.close
end
def create_gpg
	system('gpg --encrypt  --armor -r password template/ReadMe.txt')
	FileUtils.rm("template/ReadMe.txt")
	Open3.popen3("zip -r secret.zip template/")
	sleep 3.0
	#exec("cat image.jpeg secret.zip > secret.png")
	Open3.popen3('cat image.jpeg secret.zip > secret.png') { |stdin, stdout, stderr| }
end
def clean_up
	FileUtils.rm("secret.png")
	FileUtils.rm("secret.zip")
	FileUtils.rm("template/ReadMe.txt.asc")
end
create_read_me
create_gpg