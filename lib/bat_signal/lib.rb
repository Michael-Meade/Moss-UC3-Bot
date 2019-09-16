require 'fileutils'
require_relative '../plugin.rb'
class Bat
	Plugin::Files.create_dir("friends/")
	def self.dir(user_name)
<<<<<<< HEAD
		"friends/" + user_name + ".json"
	end
	def self.add_friend(uid, user_name)
		# create file if doesnt exist
		Plugin::Files.file_check(dir(user_name))
		Plugin::Files.add_custom([uid, user_name],  uid, "friends/")
	end
	def self.check_exist(uid)
		puts uid
		if not File.exists?("users/#{uid}.json")
			FileUtils.touch("friends/#{uid}.json")
		end
	end
end

Bat.add_friend("123456789", "Mc")
=======
	    "friends/" + user_name + ".json"
	end
	def self.add_friend(uid, user_name)
	     # create file if doesnt exist
	     Plugin::Files.file_check(dir(user_name))
	     Plugin::Files.add_custom([uid, user_name],  uid, "friends/")
	end
	def self.check_exist(uid)
	     if not File.exists?("users/#{uid}.json")
		FileUtils.touch("friends/#{uid}.json")
	     end
	end
end

#Bat.add_friend("123456789", "Mc")
>>>>>>> 6c8790b744e3119150b90820a7700ef4e34acc99
