require_relative 'lib/moss'
require 'fileutils'
require 'cgi'
require 'discordrb'
token = "MzgwNTgzNjk4NzkxMzk5NDI0.DO8_vQ.Vc84O0pjrQcGzDQAXeG7nBDtZqk"
bot = Discordrb::Commands::CommandBot.new token: 'MzgwNTgzNjk4NzkxMzk5NDI0.DbhQgw.L2Bo05sL3dGMM1O0cVGRRbdEgMQ', client_id:  380583698791399424, prefix: '.'
bot.command(:afbi) do |event|
	encode = Encode.encode_sha1(sha1)
	event.respond(encode)
end