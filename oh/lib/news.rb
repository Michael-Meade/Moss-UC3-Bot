require 'rss'
require 'time'
require 'json'
require 'mechanize'
require 'fileutils'
class News
	def initialize(id)
    FileUtils.mkdir_p "../news/"  unless File.exists?("../news/")
		@id = id
  end
  def createNews(news)
    t1 = Time.now 
    if not File.exists?("../news/bc.json")
      a = {"Link" => news["Link"],
           "Time" => t1}
      f = File.open("../news/bc.json", "a")
      f.write(JSON.pretty_generate(a))
      f.close
    end
  end
  def get_news
  	site = self.id_to_site
    i = 0
    rss = open(site)
    feed = RSS::Parser.parse(rss)
    feed.items.each do |item|
      until i == "1"
        i +=1
        return {"Title" => item.title, "Link" => item.link, "Description" => item.description}
        exit
      end
    end
  end
  def id_to_site
  	case @id.to_i
      when 1
        # BleepingComputer
        return "https://www.bleepingcomputer.com/feed/"
      when 2
        # RiskIQ
        return "https://www.riskiq.com/feed/"
      when 3
        # Krebs On Security
        return "https://krebsonsecurity.com/feed/"
      when 4
        # Kaspersky
        return "https://usa.kaspersky.com/blog/feed/"
      when 5
        # Check Point
        return "https://research.checkpoint.com/feed/"
      when 6
        # Malwarebytes
        return "https://blog.malwarebytes.com/feed/"
      when 7
        # trenMicro
        return "http://feeds.trendmicro.com/TrendMicroSimplySecurity"
      when 8
        # Fortinet
        return "http://feeds.feedburner.com/fortinet/blog/threat-research"
      when 9
        # securityBoulevard
        return "https://securityboulevard.com/feed/"
      when 10
        #  Zimperium
        return "https://blog.zimperium.com/feed/"
      when 11
        # darkRead
        return "https://www.darkreading.com/rss_simple.asp"
      when 12
        # threatpoint
        return "https://threatpost.com/feed/"
      when 13
        # CyberScoop
        return "https://www.cyberscoop.com/feed/"
      when 14
        # torrent Freak
        return "http://feeds.feedburner.com/Torrentfreak"
      when 15
        # DigitaTrends
        return "https://www.digitaltrends.com/feed/"
      when 16
        # us Cert
        return "https://www.us-cert.gov/ncas/analysis-reports.xml"
      when 17
        # comodo
        return "https://blog.comodo.com/feed/"
      when 18
        # HackerCombat
        return "https://hackercombat.com/feed/"
      when 19
        # ItsecGuru
        return "https://www.itsecurityguru.org/feed/"
      when 20
        # computerfruad
        return "https://computerfraud.us/feed"
      when 21
        # tradesecretslaw
        return "https://www.tradesecretslaw.com/feed/"
      when 22
        return "https://blog.avast.com/rss.xml"
      when 23
        return "https://www.fbi.gov/feeds/cyber-crimes-stories/RSS"
      end
    end
end
module NewsTest
	class << self
		def cyber_news(id)
			i = News.new(id)
			i.get_news
		end
    def news_alert
      i = News.new("1")
      currentNews = i.get_news
      i.createNews(currentNews)
    end
	end
end
