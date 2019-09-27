require'colorize'
require 'uri'
require 'net/http'
require'json'
require_relative 'crypto/bitcoinGen'
class CryptoCurrency
	def ConvertBTC(btc)
    	return btc / 100000000.0
    end
    def AddCommasToNumber(btc)
        whole, decimal = btc.to_s.split(".")
        whole_with_commas = whole.chars.to_a.reverse.each_slice(3).map(&:join).join(",").reverse
        [whole_with_commas, decimal].compact.join(".")
    end
    def ConvertBtcToUSD(btc)
    	btc = ConvertBTC(btc)
    	btc = btc.to_s.gsub(".", "")
    	response = Net::HTTP.get_response(URI.parse("https://www.blockchain.com/frombtc?value=#{btc}&currency=USD"))
    	return response.body
    end
	def generate_btc_address
		Vanity.massGenerate("1", fileToWrite=nil)
	end
	def btc
		uri = URI.parse("https://api.coinmarketcap.com/v1/ticker/bitcoin/")
        response = Net::HTTP.get_response(uri)
        data = JSON.parse(response.body)
        s = {"priceUsd" => data[0]['price_usd'].to_s,
        	 "priceBTC" => data[0]['price_btc'].to_s,
        	 "percent_change_1h" => data[0]['percent_change_1h'].to_s,
        	 "percent_change_24" => data[0]['percent_change_24h'].to_s}
	end
	def eth
		uri = URI.parse("https://api.coinmarketcap.com/v1/ticker/ethereum/")
        response = Net::HTTP.get_response(uri)
        data = JSON.parse(response.body)
        s = {"priceUsd" => data[0]['price_usd'].to_s,
        	 "priceBTC" => data[0]['price_btc'].to_s,
        	 "percent_change_1h" => data[0]['percent_change_1h'].to_s,
        	 "percent_change_24" => data[0]['percent_change_24h'].to_s}
	end
    def rvn
        uri = URI.parse("https://api.coinmarketcap.com/v1/ticker/ravencoin")
        response = Net::HTTP.get_response(uri)
        data = JSON.parse(response.body)
        s = {"priceUsd" => data[0]['price_usd'].to_s,
             "priceBTC" => data[0]['price_btc'].to_s,
             "percent_change_1h" => data[0]['percent_change_1h'].to_s,
             "percent_change_24" => data[0]['percent_change_24h'].to_s}
    end
	def xlm
		uri = URI.parse("https://api.coinmarketcap.com/v1/ticker/stellar/")
        response = Net::HTTP.get_response(uri)
        data = JSON.parse(response.body)
        s = {"priceUsd" => data[0]['price_usd'].to_s,
        	 "priceBTC" => data[0]['price_btc'].to_s,
        	 "percent_change_1h" => data[0]['percent_change_1h'].to_s,
        	 "percent_change_24" => data[0]['percent_change_24h'].to_s}
	end
	def monero
		uri = URI.parse("https://api.coinmarketcap.com/v1/ticker/monero/")
        response = Net::HTTP.get_response(uri)
        data = JSON.parse(response.body) 
        s = {"priceUsd" => data[0]['price_usd'].to_s,
        	 "priceBTC" => data[0]['price_btc'].to_s,
        	 "percent_change_1h" => data[0]['percent_change_1h'].to_s,
        	 "percent_change_24" => data[0]['percent_change_24h'].to_s}
	end
	def get_address_btc(q)
    	response = Net::HTTP.get_response(URI.parse("https://blockchain.info/rawaddr/#{q}"))
    	btc      = JSON.parse(response.body)
    	s = {"received" => self.ConvertBTC(btc["total_received"]).to_s, 
    		"sent"      => self.ConvertBTC(btc["total_sent"]).to_s,
    		"hash"      => btc["hash160"],
    		"n_tx"      => btc["n_tx"],
    		"final_bal" => self.ConvertBTC(btc["final_balance"]).to_s
    	}
    end
    def get_sentby_btc(q)
    	response = Net::HTTP.get_response(URI.parse("https://blockchain.info/q/getsentbyaddress/#{q}"))
    	btc      = JSON.parse(response.body).to_i
    	q = {"BTC" =>  self.AddCommasToNumber(btc)}
    end
	def get_btc_address_usd(q)
    	response  = Net::HTTP.get_response(URI.parse("https://blockchain.info/rawaddr/#{q}"))
    	btc       = JSON.parse(response.body)
    	s = {"received" => self.ConvertBtcToUSD(btc["total_received"]), 
    		"sent"      => self.ConvertBtcToUSD(btc["total_sent"]),
    		"hash"      => btc["hash160"],
    		"n_tx"      => btc["n_tx"],
    		"final_bal" => self.ConvertBtcToUSD(btc["final_balance"])
    	}
    end
end
module Crypto
	class << self
		BTC = CryptoCurrency.new()
		def generate_btc_address
			BTC.generate_btc_address
		end
		def getbtc_usd(q)
			BTC.get_btc_address_usd(q)
		end
		def getbtc(q)
			BTC.get_address_btc(q)
		end
		def btc
			BTC.btc
		end
		def xmr
			BTC.monero
		end
		def eth
			BTC.eth
		end
        def rvn
            BTC.rvn
        end
		def xlm
			BTC.xlm
		end
		def conver_btc2_usd(q)
			BTC.ConvertBtcToUSD(q)
		end
	end
end
