require 'httparty'
require 'json'
module ManPage
	def self.get_results(s)
		r = HTTParty.get("https://www.mankier.com/api/v2/mans/?q=#{s}").response.body
		JSON.parse(r)["results"]
	end
	def self.explain(s)
		HTTParty.get("https://www.mankier.com/api/v2/explain/?cols=70&q=#{s}").response.body.encode("UTF-8")
	end
end
#ManPage.get_results("ping")