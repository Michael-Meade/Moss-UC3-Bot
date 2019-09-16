require 'httparty'
require 'discordrb'
require_relative 'lib/moss'
bot = Discordrb::Commands::CommandBot.new token: 'MzgwNTgzNjk4NzkxMzk5NDI0.DbhQgw.L2Bo05sL3dGMM1O0cVGRRbdEgMQ', client_id:  380583698791399424, prefix: '.'
read = File.read("alert/315264930951462913.json")
a = JSON.parse(read)
cur_price = Alert.get_rvn_price
puts cur_price
a.keys.each do |keys|
	if cur_price.to_i <= a[keys].to_i
		bot.send_message("596720160627359754",  "```Value was less than #{a[keys]}".to_s + "\nCurrent Price: #{cur_price}```")
	end
	puts a[keys]
end
Alert.get_rvn_price