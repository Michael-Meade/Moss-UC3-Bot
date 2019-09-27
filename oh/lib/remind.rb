class Remind
	def initialize(uid, message)
		puts uid
		@uid = uid
		@message = message
    end
    def create_cron
    	system("crontab")
    end
    def save_remind
    	if File.exist?("reminds/#{@uid}.txt")
    		f = File.open("reminds/#{@uid}.txt", "a")
    		f.write(@message)
    		f.close
    	else
    		f = File.open("reminds/#{@uid}.txt", "w")
    		f.write(@message)
    		f.close
    	end
    end
end
