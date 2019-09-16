require "fileutils"
require 'json'
module Plugin
	class Files
		def self.create_dir(dir_name)
			FileUtils.mkdir_p(dir_name)  unless File.exists?(dir_name)
		end
		def self.file_check(file_name)
			if not File.exists?(file_name)
				FileUtils.touch(file_name)
			end
		end
		def self.add_custom2(uid, dir, file_name)
			file_check(file_name)
			read = File.read(dir +  uid + ".json")
			a    = JSON.parse(read)
			f    = File.open(dir  uid + ".json", "w")
			a[args[0]] = args[1]
			f.write(JSON.pretty_generate(a))
			f.close
		end
		def self.add_custom(file_name, *args)
			file_check(file_name)
			read = File.read(file_name)
			a    = JSON.parse(read)
			f    = File.open(file_name, "w")
			a[args[0]] = args[1]
			f.write(JSON.pretty_generate(a))
			f.close
		end
	end
end

#Plugin::Files.file_check("bat_signal/mike2.txt")