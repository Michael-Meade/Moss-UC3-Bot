require 'discordrb'
require_relative 'lib/moss'

bot = Discordrb::Commands::CommandBot.new token: 'MzgwNTgzNjk4NzkxMzk5NDI0.DbhQgw.L2Bo05sL3dGMM1O0cVGRRbdEgMQ', client_id:  380583698791399424, prefix: '.', add_channel: read = File.read("news/bc.json")
a = JSON.parse(read)["Title"]
bc = NewsTest.cyber_news("1")
if bc["Title"] != a
	bot.send_message("360584714672930816",  bc["Link"])
	fileRead = File.read("news/bc.json")
	a = JSON.parse(fileRead)
	f = File.open("news/bc.json", "w")
	a["Title"] = bc["Title"]
	f.write(JSON.pretty_generate(a))
end
