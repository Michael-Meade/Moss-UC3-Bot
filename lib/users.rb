require 'fileutils'
require 'json'
class UserInfo
	def initialize(id, value=nil)
		@id = id
		@value = value
		puts @id
		# Uname can also be used to look up the name
		FileUtils.mkdir_p "users/"  unless File.exists?("users/")
		@file = "users/" + @id + ".json"
		if not File.exists?(@file)
			if @id != "0"
				f = File.open(@file, "a") 
				f.write(JSON.pretty_generate({"ID" => @id,
				                          "Snap"   => "0",
			                              "Ig"     => "0",
			                              "Number" => "0",
			                              "Email"  => "0",
			                              "Alias"  =>  []}))
				f.close
			end
		end
    end
    def add_custom(value2)
    	read = File.read(@file)
    	puts read
    	a = JSON.parse(read)
    	f = File.open(@file, "a")
    	a[@value] = value2
    	f.write(JSON.pretty_generate(a))
    	f.close
    end
    def read_file
    	read = File.read(@file)
    	a = JSON.parse(read)
    end
    def get_id_alias
    	i = 0
    	Dir.glob("users/*").each do |a|
    		fileRead = File.read(a)
    		check    = JSON.parse(fileRead)
    		if check["Alias"].include?(@value)
    			return check["ID"]
    		end
    		i+=1
    	end
    	nil
    end
    def add_alias
    	fileRead = File.read(@file)
    	a = JSON.parse(fileRead)
    	f = File.open(@file, "w")
    	a["Alias"] << @value
    	f.write(JSON.pretty_generate(a))
    	f.close
    end
    def look_up
    	read = File.read(@file)
    	f = JSON.parse(read)
    	puts f[@value]
    end
    def add_value(id, value)
    	fileRead = File.read(@file)
    	a = JSON.parse(fileRead)
    	f = File.open(@file, "w")
    	a[id] = value
    	f.write(JSON.pretty_generate(a))
    	f.close
    end
    def add_ig
    	add_value("Ig", @value)
    end
    def add_snapchat
    	add_value("Snap", @value)
    end
    def add_number
    	add_value("Number", @value)
    end
    def school_email
    	add_value("Email", @value)
    end
end
module User_Info
	class << self
		def snap_chat(id, snap)
			puts "MIKE: #{snap}"
			id = UserInfo.new(id, snap)
			id.add_snapchat
		end
		def read_file(id)
			id = UserInfo.new(id, value=nil)
			id.read_file
		end
		def ig(id, ig)
			id = UserInfo.new(id, ig)
			id.add_ig
		end
		def school_email(id, email)
			id = UserInfo.new(id, email)
			id.school_email
		end
		def phone_number(id, number)
			id = UserInfo.new(id, number)
			id.add_number
		end
		def custom(id, value, value2)
			id = UserInfo.new(id, value)
			id.add_custom(value2)
		end
		def look_up(id, uname)
			id = UserInfo.new(id, uname)
			id.look_up
		end
		def alias_add(id, value)
			id = UserInfo.new(id, value)
			id.add_alias
		end
		def getidbyalias(id, value)
			id = UserInfo.new(id, value)
			id.get_id_alias
		end
	end
end

#User_Info.read_file("315264930951462913", "0")
