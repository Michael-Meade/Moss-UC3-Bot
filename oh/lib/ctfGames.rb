require 'fileutils'
class CTF_Games
	XOR = "aHR0cHM6Ly93d3cueW91dHViZS5jb20vd2F0Y2g/dj1kUXc0dzlXZ1hjUQ== is the answer to flat earth conspiracy "
	def initialize(id)
		@id = id
		FileUtils.mkdir_p "ctf/"  unless File.exists?("ctf/")
		@file = "ctf/" + @id + ".json"
		if not File.exists?(@file)
			f = File.open(@file, "a") 
			f.write(JSON.pretty_generate({"Xor" => ""})
		end
	end
	def write_file(key, answer)
		read = File.read(@file)
    	a = JSON.parse(read)
    	f = File.open(@file, "w")
    	a[key] = answer
    	f.write(JSON.pretty_generate(a))
    	f.close
	end
	def crack_xor
		if rand(1..10) ==
	end
end