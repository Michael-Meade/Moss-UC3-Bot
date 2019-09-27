require 'fileutils'
class AdminControl
	def initialize(uid)
		@uid = uid
		FileUtils.mkdir_p "admin/"  unless File.exists?("admin/")
    end
	def check_admin
		if File.exists?("admin/" + @uid + ".json")
			true
		end
	end
	def remove_admin(admin_to_remove)
		begin
			if self.check_admin
				FileUtils.rm("admin/" + admin_to_remove + ".json")
				dict = {"Status" => "Removed Admin."}
			end
		rescue => e
			dict = {"Status" => "Failed to remove admin"}
		end
	end
	def add_key(key, value)
		begin
			if self.check_admin
				fileRead = File.read(@file)
				a = JSON.parse(fileRead)
				f = File.open("admin/#{@uid}.json", "w")
				a[key] = value
				f.write(JSON.pretty_generate(a))
			end
		rescue => e
			dict = {"Status" => "Error in adding value and key."} 
		end
	end
	def create_cron(cron)
		if cron["cron"].match("(28|\*) (2|\*) (7|\*) (1|\*) (1|\*)")
			c1 = "(crontab -l 2>/dev/null;"
			c2 = 'echo "0 4 * * * /mnt/c/Users/Mclovin/Desktop/ruby/Uc-Bot/lib/cronsend.rb")| crontab -'.gsub("0 4 * * *", cron["cron"])
			system('')
		else
			a = {"Status" => "Error in Cron time."}
		end
		#system("")
	end
	def add_admin(admin_to_add)
		begin
			if self.check_admin
				f = File.open("lib/admin/#{admin_to_add}.json", "a")
				f.write(JSON.pretty_generate({"Rank"   => "0"}))
				f.close
				dict = {"Status" => "Added admin"}
			end
		rescue => e
			dict = {"Status" => "Failed to add Admin."}
		end
	end
end
module Admin
	class << self
		def check_admin(uid)
			a = AdminControl.new(uid)
			a.check_admin
		end
		def adding_admin(uid, admin_to_add)
			a = AdminControl.new(uid)
			a.add_admin(admin_to_add)
		end
		def adding_key(key, value, uid)
			a = AdminControl.new(uid)
			a.add_key(key, value)
		end
	end
end

Admin.adding_admin("mike", "k")