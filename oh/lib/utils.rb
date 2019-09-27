<<<<<<< HEAD
require "fileutils"
require 'json'
=======
>>>>>>> 6c8790b744e3119150b90820a7700ef4e34acc99
class Utils
	def self.create_dir(dir)
		FileUtils.mkdir_p dir  unless File.exists?(dir)
    end
<<<<<<< HEAD
    def self.create_dir(dir_name)
		FileUtils.mkdir_p(dir_name)  unless File.exists?(dir_name)
	end
	def self.file_check(file_name)
		if not File.exists?(file_name)
			FileUtils.touch(file_name)
		end
	end
	def self.check_empty(file_name)
		File.zero?(file_name)
	end
	def self.read_list(file_name)
		file_check(file_name)
		list = File.read(file_name)
		JSON.parse(list)
	end
	def self.create_list(file_name)
		i    = 0
		list = ""
		read_list(file_name).each do |key, values|
			list += "#{key}] #{values}\n"
		end
		return list
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
	def self.get_last_key(file)
		file_check(file)
		read  = File.read(file)
		read2 = JSON.parse(read)
		id = read2.keys.last.to_i
		id +=1
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
=======
>>>>>>> 6c8790b744e3119150b90820a7700ef4e34acc99
end