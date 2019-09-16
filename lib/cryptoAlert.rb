require 'json'
class Alert
	FileUtils.mkdir_p "alert/"  unless File.exists?("alert/")
	def self.rvn_alert(id, price)
		if not File.exists?("alert/#{id}.json")
			f = File.open("alert/#{id}.json", "a") 
			f.write(JSON.pretty_generate({"price" => price}))
			f.close
		else
			read = File.read("alert/#{id}.json")
	    	a = JSON.parse(read)
	    	f = File.open("alert/#{id}.json", "w")
	    	a["price" + rand(0..2222).to_s] = price
	    	f.write(JSON.pretty_generate(a))
	    	f.close
		end
	end
	def self.get_rvn_price
		price = HTTParty.get("https://api.binance.com/api/v3/ticker/price?symbol=RVNBTC")
		price.parsed_response["price"]
	end
	
end