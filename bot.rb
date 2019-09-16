require_relative 'lib/moss'
require 'fileutils'
require 'cgi'
require 'discordrb'
token = "MzgwNTgzNjk4NzkxMzk5NDI0.DO8_vQ.Vc84O0pjrQcGzDQAXeG7nBDtZqk"
bot = Discordrb::Commands::CommandBot.new token: 'MzgwNTgzNjk4NzkxMzk5NDI0.DbhQgw.L2Bo05sL3dGMM1O0cVGRRbdEgMQ', client_id:  380583698791399424, prefix: '.'
bot.command(:sha1, min_args:1) do |event, sha1|
	encode = Encode.encode_sha1(sha1)
	event.respond(encode)
end
bot.command(:domainexist) do |event, domain|
	d = Fun.domain_exist(domain)
	event.respond("Available: #{d["available"]}"  "\n\n" + "Registered #{d["registered"]}")
end
bot.command(:md5, min_args:1) do |event, md5|
	encode = Encode.encode_md5(md5)
	event.respond(encode)
end
bot.command(:base64, min_args:1) do |event, base64|
	event.respond(Encode.encode_base64(base64))
end
bot.command(:unbase64, min_args:1) do |event, unbase64|
	event.respond(Encode.decode_base64(unbase64))
end
bot.command(:unbacon, min_args:1) do |event, unbacon|
	event.respond(Encode.decode_bacon(unbacon))
end
bot.command(:bacon, min_args:1) do |event, bacon|
	event.respond(Encode.encode_bacon(bacon))
end
bot.command(:binary, min_args:1) do |event, binary|
	event.respond(Encode.encode_binary(binary).shift)
end
bot.command(:unbinary, min_args:1) do |event, binary|
	event.respond(Encode.decode_binary(binary))
end
bot.command(:hex, min_args:1) do |event, hex|
	event.respond(Encode.encode_hex(hex))
end
bot.command(:unhex, min_args:1) do |event, unhex|
	event.respond(Encode.hex_decode(unhex))
end
bot.command(:ceaser, min_args:1) do |event, ceaser, shift|
	event.respond(Encode.caesar_cipher(ceaser, shift=1).shift.to_s)
end
bot.command(:reverse, min_args:1) do |event, text|
	event.respond(Encode.reverse_string(text))
end
bot.command(:encodexor, min_args:2) do |event, key, msg|
	event.respond(Encode.xor(key, msg).to_s)
end
bot.command(:length, min_args:1) do |event, text|
	event.respond(Encode.string_length(text))
end
bot.command(:bee) do |event|
	event.respond(":ghost: :bee:")
end
bot.command(:iplook) do |event, q|
	s = Searching.iplook(q)
	event.channel.send_embed(" ") do |embed|
  		#embed.title = s['ip']
  		embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(url:"https://ipgeolocation.io/static/flags/us_64.png")
  		embed.colour = 0xf20b27
  		embed.add_field(name: "Country", 		value: s['country_name'])
  		embed.add_field(name: "State",  		value: s['state_prov'])
  		embed.add_field(name: "City",    		value: s['city'])
  		embed.add_field(name: "Zip",     		value: s['zipcode'])
  		embed.add_field(name: "latitude",		value: s['latitude'])
  		embed.add_field(name: "longitude",		value: s['longitude'])
  		embed.add_field(name: "ISP",        	value: s['isp'])
  		embed.add_field(name: "organization",	value: s['organization'])
  		embed.add_field(name: "TimeZone",	    value: s['time_zone']['name'])
	end
end

bot.command(:weed) do |event, s, num|
	if num.nil?
		number = 0
	end
	info = Weeds.strain_info(s, num)
	event.channel.send_embed(" ") do |embed|
  		embed.title = info["name"]
  		embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(url:"https://www.getmonero.org/press-kit/symbols/monero-symbol-1280.png")
  		embed.colour = 0xf20b27
  		embed.add_field(name: "Alias", value: info["alias"])
  		embed.add_field(name: "Sativa percent", value: info["sativaPercent"])
  		embed.add_field(name: "Indica percent", value: info["indicaPercent"])
  		embed.add_field(name: "Type of High  ", value: info["typeOfHigh"])
	end
end
bot.command(:weedinfo) do |event, q, num|
	if num.nil?
		num = 0
	end
	info = Weeds.get_info(q, num)
	event.respond(info)
end
bot.command(:rot13, min_args:1) do |event, shift, text|
	event.respond(Encode.encode_rot13(text, shift=13))
end
bot.command(:man) do |event, term|
	event.respond "http://man.he.net/?topic=" + term.to_s + "&section=all"
end
bot.command(:who_is, min_args: 1) do |event, domain|
	s = Searching.who(domain)
	event.channel.send_embed(" ") do |embed|
  		embed.title = "#{domain}"
  		embed.add_field(name: "Status", value: "#{s['status']}")
  		embed.add_field(name: "Created", value: "#{s['created']}")
  		embed.add_field(name: "Updated on", value:   "#{s['updated_on']}")
  		embed.add_field(name: "Expires on", value: "#{s['expires_on']}")
  		embed.add_field(name: "Address", value: "#{s['address']}")
  		embed.add_field(name: "Registrant Contacts", value: "#{s['registrant_contacts']}")
  		embed.add_field(name: "Admin Name", value: "#{s['admin name']}")
  		embed.add_field(name: "Organization", value: "#{s['organization']}")
  		embed.add_field(name: "Admin Address", value: "#{s['Admin Address']}")
  		embed.add_field(name: "Tech Name", value: "#{s['Technical Name']}")
  		embed.add_field(name: "Tech Address", value: "#{s['Tech Address']}")
  		embed.add_field(name: "Name Servers", value: "#{s['nameservers']}")
	end
end

bot.command(:xmr) do |event|
	xmr = Crypto.xmr
	event.channel.send_embed(" ") do |embed|
  		embed.title = "XMR price"
  		embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(url:"https://www.getmonero.org/press-kit/symbols/monero-symbol-1280.png")
  		embed.colour = 0xf20b27
  		embed.add_field(name: "Price USD", value: "$ #{xmr["priceUsd"]}")
  		embed.add_field(name: "Price BTC", value: "$#{xmr["priceBTC"]}")
  		embed.add_field(name: "Percent change 1 hr", value:   "#{xmr["percent_change_1h"]} %")
  		embed.add_field(name: "Percent change 24 hrs", value: "#{xmr["percent_change_24"]} %")
	end
end
bot.command(:rvn) do |event|
	eth = Crypto.eth
	event.channel.send_embed(" ") do |embed|
  		embed.title = "RVN price"
  		embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(url:"http://static1.squarespace.com/static/5b4ea0804eddec73df84179c/t/5b4ea76803ce64a010ea5c26/1531881323382/ravencoin.png")
  		embed.colour = 0xf20b27
  		embed.add_field(name: "Price USD", value: "$ #{eth["priceUsd"]}")
  		embed.add_field(name: "Price BTC", value: "$ #{eth["priceBTC"]}")
  		embed.add_field(name: "Percent change 1 hr", value:   "#{eth["percent_change_1h"]} %")
  		embed.add_field(name: "Percent change 24 hrs", value: "#{eth["percent_change_24"]} %")
	end
end
bot.command(:eth) do |event|
	eth = Crypto.eth
	event.channel.send_embed(" ") do |embed|
  		embed.title = "ETH price"
  		embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(url:"https://etherscan.io/images/ethereum-icon.png")
  		embed.colour = 0xf20b27
  		embed.add_field(name: "Price USD", value: "$ #{eth["priceUsd"]}")
  		embed.add_field(name: "Price BTC", value: "$ #{eth["priceBTC"]}")
  		embed.add_field(name: "Percent change 1 hr", value:   "#{eth["percent_change_1h"]} %")
  		embed.add_field(name: "Percent change 24 hrs", value: "#{eth["percent_change_24"]} %")
	end
end
bot.command(:xlm) do |event|
	xlm = Crypto.xlm
	event.channel.send_embed(" ") do |embed|
  		embed.title = "XLM price"
  		embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(url:"https://upload.wikimedia.org/wikipedia/commons/5/56/Stellar_Symbol.png")
  		embed.colour = 0xf20b27
  		embed.add_field(name: "Price USD", value: "$ #{xlm["priceUsd"]}")
  		embed.add_field(name: "Price BTC", value: "$ #{xlm["priceBTC"]}")
  		embed.add_field(name: "Percent change 1 hr", value:   "#{xlm["percent_change_1h"]} %")
  		embed.add_field(name: "Percent change 24 hrs", value: "#{xlm["percent_change_24"]} %")
	end
end
bot.command(:btc2usd) do |event, price|
	money = Crypto.conver_btc2_usd(price)
	event.respond(money)
end
bot.command(:btc) do |event|
	xmr = Crypto.btc
	event.channel.send_embed(" ") do |embed|
  		embed.title = "BTC price"
  		embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(url:"https://en.bitcoin.it/w/images/en/2/29/BC_Logo_.png")
  		embed.colour = 0xf20b27
  		embed.add_field(name: "Price USD", value: "$ #{xmr["priceUsd"]}")
  		embed.add_field(name: "Price BTC", value: "$ #{xmr["priceBTC"]}")
  		embed.add_field(name: "Percent change 1 hr", value:   "#{xmr["percent_change_1h"]} %")
  		embed.add_field(name: "Percent change 24 hrs", value: "#{xmr["percent_change_24"]} %")
	end
end
bot.command(:upload) do |event, url, name|
	Upload.add_file(event.user.id.to_s, url, name)
end
bot.command(:btcaddy, min_args: 2, usage: ".btcaddy <address> usd OR btc") do |event, addy, num|
	if num.downcase == "usd"
		btc = Crypto.getbtc_usd(addy)
		event.channel.send_embed(" ") do |embed|
	  		embed.title = addy
	  		embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(url:"https://en.bitcoin.it/w/images/en/2/29/BC_Logo_.png")
	  		embed.colour = 0xf20b27
	  		embed.add_field(name: "Received", value: "$#{btc["received"]}")
	  		embed.add_field(name: "Final Balance", value: "$#{btc["final_bal"]}")
	  		embed.add_field(name: "Sent", value: "$#{btc["sent"]}")
	  		embed.add_field(name: "Hash", value: "#{btc["hash"]}")
	  		embed.add_field(name: "Transactions", value: "#{btc["n_tx"]}")
		end
	elsif num.downcase == "btc"
		btc = Crypto.getbtc(addy)
		event.channel.send_embed(" ") do |embed|
	  		embed.title = addy
	  		embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(url:"https://en.bitcoin.it/w/images/en/2/29/BC_Logo_.png")
	  		embed.colour = 0xf20b27
	  		embed.add_field(name: "Received", value: "₿ #{btc["received"]}")
	  		embed.add_field(name: "Final Balance", value: "₿ #{btc["final_bal"]}")
	  		embed.add_field(name: "Sent", value: "₿ #{btc["sent"]}")
	  		embed.add_field(name: "Hash", value: " #{btc["hash"]}")
	  		embed.add_field(name: "Transactions", value: "#{btc["n_tx"]}")
		end
	else
		event.respond("please input 'btc' or 'usd'.")
	end
end
bot.command(:btcwallet) do |event|
	#event.user.id.to_s
	begin
		address = Crypto.generate_btc_address
		event.user.send_file(File.open("wallets/" + address + ".txt"))
		#event.send_file(File.open("wallets/" + address + ".txt"))
		event.respond("check ur pms.... Btw: the file was deleted from vps.")
		begin
			FileUtils.rm("wallets/#{address}.txt")
		rescue => e
			puts e
			event.user.pm("Error with deleting wallet. Going old school. ")
			#event.respond("Error with deleting wallet. Going old school. ")
			system("rm -rf wallets/#{address}.txt")
		end
	rescue => e
		puts e
		#event.respond("Error with BTC wallet")
		event.user.pm("Error with deleting wallet. Going old school. ")
	end
	nil
end
bot.command(:adminize) do |event, user|
	tag = event.channel.mention.to_s.gsub("<", "").gsub(">", "").gsub("#", "")
	puts tag
	if Admin.check_admin(event.user.id.to_s)
		results = Admin.adding_admin(event.user.id.to_s, tag)
	end
	event.respond(results["Status"])
end
bot.command(:announce) do |event, text|
	if Admin.check_admin(event.user.id.to_s)
		bot.send_message("377675427659120661", text).pin
	end
end
bot.command(:stab) do |event, user|
	event.respond(Fun.stab_user(user, event.user.name.to_s))
end
bot.command(:del, min_args:1, usage: ".del user", description: "Delete your friends sys32") do |event, user|
	event.respond(Fun.sys32(user, event.user.name.to_s))
end
bot.command(:ddos, min_args:1,  usage:".ddos user", description:"ddos your friend") do |event, user|
	event.respond(Fun.ddos_user(user, event.user.name.to_s))
end
bot.command(:beerme) do |event, user|
	if user.nil?
		user = event.user.name
	end
	event.respond(Fun.beer_user(user))
	bot.send_file(event.channel.id, File.open('images/beer.gif', 'r'))
end
bot.command(:hppass) do |event|
	pot = Searching.username
	string = ""
	i = 0
	pot.each do |key, values|
		string += i.to_s +  "] " + key  + "----------"  + values.to_s + "\n"
		i+=1
	end
	event.respond("#{string}")
end
bot.command(:joint) do |event, user|
	if user.nil?
		user = event.user.name
	end
	event.respond("Hands #{user} a joint with 'oregano' in it :wink:")
end
bot.command(:deadpool) do |event|
	bot.send_file(event.channel.id, File.open('images/dead.gif', 'r'))
end
bot.command(:dab) do |event|
	bot.send_file(event.channel.id, File.open('images/dab.gif', 'r'))
end
bot.command(:ok) do |event|
	bot.send_file(event.channel.id, File.open('images/ok.gif', 'r'))
end
bot.command([:tiny, :sad]) do |event|
	bot.send_file(event.channel.id, File.open('images/sad.gif', 'r'))
end
bot.command(:ron) do |event|
	event.respond(Fun.get_pun)	
end
bot.command(:geek) do |event|
	event.respond(Fun.geek_jokes)
end
bot.command(:wack) do |event|
	event.respond("https://i.imgur.com/ciL01wx.jpg")
end
bot.command(:catfact) do |event|
	event.respond(Fun.cats_facts)
end
bot.command(:yesorno) do |event, question|
	event.respond(Fun.yes_or_no)
end
bot.command(:cookie) do |event, user|
	event.respond(Fun.give_cookie(user))
end
bot.command(:yt, min_args:1) do |event, q, value|
	#puts Searching.youtube(q, value).to_s
	event.respond(Searching.youtube(q, value).to_s)
end

bot.command(:gif, min_args:1) do |event, q|
	event.respond(Searching.gif_search(q))
end
bot.command(:moviedb, min_args:1) do |event, *q|
	
	puts q
	event.respond(Searching.moviedb(q)["Movie"].to_s)
end
bot.command(:w, min_args:1) do |event, q|
	event.respond(Searching.weather(q))
end
bot.command(:wiki, min_args:1 ) do |event, q|
	event.respond(Searching.wikia(q.to_s))
end
bot.command(:u, min_args:1 ) do |event, q, value|
	event.respond(Searching.urban(q, value=0))
end
bot.command(:rand) do |event|
	puts Meme.random.to_s
	event.respond(Meme.random.to_s)
end
bot.command(:source) do |event|
	event.respond("https://github.com/Michael-Meade/Moss-UC3-Bot")
end
bot.command(:memecards) do |event|
	event.respond(Meme.pic_easy("memecards"))
end
bot.command(:uclinks) do |event|
	event.channel.send_embed(" ") do |embed|
		embed.add_field(name: "ResNet",          value:  "https://www.utica.edu/academic/iits/compuserservices/network/info.cfm")
		embed.add_field(name: "Tickets",         value:  "https://uticatickets.universitytickets.com")
		embed.add_field(name: "Software",        value:  "https://software.utica.edu")
		embed.add_field(name: "Pioneerplace",    value:  "http://pioneerplace.utica.edu")
		embed.add_field(name: "Password",        value:  "https://password.utica.edu")
		embed.add_field(name: "Engage",          value:  "http://engage.utica.edu")
		embed.add_field(name: "BannerWeb",       value:  "http://bannerweb.utica.edu")
		embed.add_field(name: "WebMail",         value:  "https://mail.google.com/a/utica.edu")
	end
end
bot.command(:ctf) do |event|
	#event.message.id
	reactions = %w(🇦 🇧 🇨 🇩 🇪)
	option = []
	string =  "```Click the reaction to get a challenge.\n"
	string += "1️⃣  Random ctf		2️⃣ Python challenge\n"
	string += "3️⃣  Steg    \n```"
	msg = event.respond(string)
	msg.create_reaction("🇦")
	msg.create_reaction("🇧")
	msg.create_reaction("🇨")
	sleep(10)
	i = 0
	ii = []
	reactions.each do |a|
		count = msg.reacted_with(a).length
		ii << count
	end
	puts ii
	ii.each do |b|
		if b.to_i > 1
			count  = ii.index(b)
			file  = CTF.decide(count)
		end
	end
end
bot.command(:decide) do |event|
	event.respond(["yes", "no"].sample.to_s)
end
bot.command(:gpg) do |event|
	pgp = CTF.run_gpg
	bot.send_file(event.channel.id, File.open(pgp, 'r'))
end
bot.command(:pyctf) do |event|
	file = CTF.generate_python
	bot.send_file(event.channel.id, File.open(file, 'r'))
	CTF.delete_generated_python
end
bot.command([:cryptohelp, :helpcrypt]) do |event|
	event.respond("https://i.imgur.com/BEtevqu.png")
end
bot.command(:morning) do |event|
	event.respond(Meme.pic_easy("morning"))
end
bot.command(:yolo) do |event|
	event.respond(Meme.pic_easy("yolo"))
end
bot.command(:tpb) do |event|
	event.respond(Meme.pic_easy("tpb"))
end
bot.command(:silicon) do |event|
	event.respond(Meme.pic_easy("silicon"))
end
bot.command(:cyber) do |event|
	event.respond(Meme.pic_easy("cyber"))
end
bot.command([:nou, :noyou]) do |event|
	event.respond(Meme.pic_easy("no_you"))
end
bot.command(:dope) do |event|
	event.respond(Meme.pic_easy("dope"))
end
bot.command(:johncenta) do |event|
	event.respond(Meme.pic_easy("johncenta"))
end
bot.command(:dogs) do |event|
	event.respond(Meme.pic_easy("dogs"))
end
bot.command(:community) do |event|
	event.respond(Meme.pic_easy("community"))
end
bot.command(:spider) do |event|
	event.respond(Meme.pic_easy("spider"))
end
bot.command(:simpsons) do |event|
	event.respond(Meme.pic_easy("simpsons"))
end
bot.command(:scrubs) do |event|
	event.respond(Meme.pic_easy("scrubs"))
end
bot.command(:office) do |event|
	event.respond(Meme.pic_easy("office"))
end
bot.command(:alert) do |event, price|
	Alert.rvn_alert(event.user.id.to_s, price)
end
bot.command(:itcrowd) do |event|
	event.respond(Meme.pic_easy("itcrowd"))
end
bot.command(:hackerman) do |event|
	event.respond("https://i.imgur.com/kx8y308.mp4")
end
bot.command(:smart) do |event|
	event.respond("https://media2.giphy.com/media/d3mlE7uhX8KFgEmY/giphy.gif")
end
bot.command(:yup) do |event|
	event.respond("https://i.imgur.com/Ja4zTze.gif")
end

bot.command(:pepe) do |event|
	event.respond(Meme.pepe.to_s)
end
bot.command(:ig) do |event, uname|
	User_Info.ig(event.user.id.to_s, uname)
end
bot.command(:snap) do |event, snap|
	User_Info.snap_chat(event.user.id.to_s, snap)
end
bot.command(:email) do |event, email|
	User_Info.school_email(event.user.id.to_s, email)
end
bot.command(:number) do |event, number|
	User_Info.phone_number(event.user.id.to_s, number)
end
bot.command(:lookup) do |event, user|
	User_Info.look_up(event.user.id.to_s, user)
end
bot.command(:afbi) do |event|
	puts
end
bot.command(:alias) do |event, user, aliass|
	if not event.message.mentions.at(0).id.nil?
		uid = event.message.mentions.at(0).id
		User_Info.alias_add(uid.to_s, aliass)
	end
	User_Info.alias_add(event.user.id.to_s, aliass)
end
bot.command(:test) do |event, user|
	puts User_Info.getidbyalias("0", "mc")
	nil
end
bot.command(:bc) do |event|
	bc = NewsTest.cyber_news("1")
	event.channel.send_embed(" ") do |embed|
  		embed.title = bc["Title"]
  		embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(url:"https://thugcrowd.com/notes/20190319/bleep.png")
  		embed.colour = 0xf20b27
  		embed.url = bc["Link"]
  		embed.description = bc["Description"]
  		embed.timestamp = Time.at(1558302217)
	end
end
bot.command(:riskiq) do |event|
	risk = NewsTest.cyber_news("2")
	event.channel.send_embed(" ") do |embed|
  		embed.title = risk["Title"]
  		embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(url:"https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/RiskIQ-Logo.png/220px-RiskIQ-Logo.png")
  		embed.colour = 0xf20b27
  		embed.url = risk["Link"]
  		embed.description = risk["Description"].gsub!(/<.*?>/, '')
  		embed.timestamp = Time.at(1558302217)
	end
end
bot.command(:yify) do |event, q|
	q = Searching.yify(q).to_s
	puts q
	event.channel.send_embed(" ") do |embed|
  		embed.title = q['Title']
  		embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(url: q['pic'])
  		embed.colour = 0xf20b27
  		embed.add_field(name: "Year", 		value: q['Year'])
	  	embed.add_field(name: "Rating", 	value: q['Rating'])
	  	embed.add_field(name: "RuntTime", 	value: q['RuntTime'])
	  	embed.add_field(name: "Genre", 		value: q['Genre'])
	  	embed.add_field(name: "Summary",    value: q['Summary'])
	  	embed.add_field(name: "Torrent",    value: q['Torrent'])
	  	embed.add_field(name: "Quality",    value: q['Quality'])
	  	embed.add_field(name: "Seeds",    	value: q['Seeds'])
	  	embed.add_field(name: "Peers",    	value: q['Peers'])
	  	embed.add_field(name: "Size",    	value: q['Size'])
	end
end
bot.command(:krebs) do |event|
	krebs = NewsTest.cyber_news("3")
	event.channel.send_embed(" ") do |embed|
  		embed.title = krebs["Title"]
  		embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(url:"https://krebsonsecurity.com/wp-content/themes/krebsads/krebsads/images/header.jpg")
  		embed.colour = 0xf20b27
  		embed.url = krebs["Link"]
  		embed.description = krebs["Description"]
  		embed.timestamp = Time.at(1558302217)
	end
	
end
bot.command(:dafbi) do |event|
	dafbi = Afbi.dafbi
	puts dafbi
	event.respond(dafbi)
end
bot.command(:kasp) do |event|
	kasp = NewsTest.cyber_news("4")
	event.channel.send_embed(" ") do |embed|
  		embed.title = kasp["Title"]
  		embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(url:"https://steemitimages.com/DQmPByK2SgHysbVVhLkS6PQ1HPWUaV6Y7gpjJfqSeq2vTZ4/kaspersky-logo.png.33058149025b8ec1bb81f29a71ecef41.png")
  		embed.colour = 0xf20b27
  		embed.url = kasp["Link"]
  		embed.description = kasp["Description"]
  		embed.timestamp = Time.at(1558302217)
	end
end
bot.command(:checkpoint) do |event|
	kasp = NewsTest.cyber_news("5")
	event.channel.send_embed(" ") do |embed|
  		embed.title = kasp["Title"]
  		embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(url:"https://www.checkpoint.com/wp-content/themes/checkpoint-theme-v2/images/check-point-logo.png")
  		embed.colour = 0xf20b27
  		embed.url = kasp["Link"]
  		embed.description = kasp["Description"].gsub!(/<.*?>/, '')
  		embed.timestamp = Time.at(1558302217)
	end
end
bot.command(:bytes) do |event|
	kasp = NewsTest.cyber_news("6")
	event.channel.send_embed(" ") do |embed|
  		embed.title = kasp["Title"]
  		embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(url:"https://www.malwarebytes.com/support/guides/mbam/images/SmallCompanyLogo.png")
  		embed.colour = 0xf20b27
  		embed.url = kasp["Link"]
  		embed.description = kasp["Description"].gsub!(/<.*?>/, '')
  		embed.timestamp = Time.at(1558302217)
	end
end
bot.command(:trendmicro) do |event|
	kasp = NewsTest.cyber_news("7")
	event.channel.send_embed(" ") do |embed|
  		embed.title = kasp["Title"]
  		embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(url:"https://upload.wikimedia.org/wikipedia/commons/thumb/e/e2/Trend-Micro-Logo.svg/800px-Trend-Micro-Logo.svg.png")
  		embed.colour = 0xf20b27
  		embed.url = kasp["Link"]
  		embed.description = kasp["Description"].gsub!(/<.*?>/, '')
  		embed.timestamp = Time.at(1558302217)
	end
end
bot.command(:fortinet) do |event|
	kasp = NewsTest.cyber_news("8")
	event.channel.send_embed(" ") do |embed|
  		embed.title = kasp["Title"]
  		embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(url:"https://upload.wikimedia.org/wikipedia/commons/thumb/6/62/Fortinet_logo.svg/1280px-Fortinet_logo.svg.png")
  		embed.colour = 0xf20b27
  		embed.url = kasp["Link"]
  		embed.description = kasp["Description"].gsub!(/<.*?>/, '')
  		embed.timestamp = Time.at(1558302217)
	end
end
bot.command(:sb) do |event|
	kasp = NewsTest.cyber_news("9")
	event.channel.send_embed(" ") do |embed|
  		embed.title = kasp["Title"]
  		embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(url:"https://www.tcell.io/wp-content/uploads/2018/08/security-boulevard-logo.png")
  		embed.colour = 0xf20b27
  		embed.url = kasp["Link"]
  		embed.description = kasp["Description"].gsub!(/<.*?>/, '')
  		embed.timestamp = Time.at(1558302217)
	end
end
bot.command(:zimp) do |event|
	kasp = NewsTest.cyber_news("10")
	event.channel.send_embed(" ") do |embed|
  		embed.title = kasp["Title"]
  		embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(url:"https://cybersecurity-excellence-awards.com/wp-content/uploads/2016/01/885518.png")
  		embed.colour = 0xf20b27
  		embed.url = kasp["Link"]
  		embed.description = kasp["Description"].gsub!(/<.*?>/, '')
  		embed.timestamp = Time.at(1558302217)
	end
end
bot.command(:darkreading) do |event|
	kasp = NewsTest.cyber_news("11")
	event.channel.send_embed(" ") do |embed|
  		embed.title = kasp["Title"]
  		embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(url:"http://d1506sp6x4e9z7.cloudfront.net/gamasutra/uploads/995355.png")
  		embed.colour = 0xf20b27
  		embed.url = kasp["Link"]
  		embed.description = kasp["Description"].gsub!(/<.*?>/, '')
  		embed.timestamp = Time.at(1558302217)
	end
end
bot.command(:threatpost) do |event|
	kasp = NewsTest.cyber_news("12")
	event.channel.send_embed(" ") do |embed|
  		embed.title = kasp["Title"]
  		embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(url:"https://blog.jscrambler.com/content/images/2018/09/jscrambler-blog-top-10-podcasts-for-cyber-security-professionals-threatpost.png")
  		embed.colour = 0xf20b27
  		embed.url = kasp["Link"]
  		embed.description = kasp["Description"]
  		embed.timestamp = Time.at(1558302217)
	end
end
bot.command(:cyberscoop) do |event|
	kasp = NewsTest.cyber_news("13")
	event.channel.send_embed(" ") do |embed|
  		embed.title = kasp["Title"]
  		embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(url:"https://s3-us-west-2.amazonaws.com/cyberscoop-media/wp-content/uploads/2016/08/12152722/CyberScoop-RGB-Color.png")
  		embed.colour = 0xf20b27
  		embed.url = kasp["Link"]
  		embed.description = kasp["Description"].gsub!(/<.*?>/, '')
  		embed.timestamp = Time.at(1558302217)
	end
end
bot.command(:torrentfreak) do |event|
	kasp = NewsTest.cyber_news("14")
	event.channel.send_embed(" ") do |embed|
  		embed.title = kasp["Title"]
  		embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(url:"http://www.userlogos.org/files/logos/danger83/torrentfreakpink.png")
  		embed.colour = 0xf20b27
  		embed.url = kasp["Link"]
  		embed.description = kasp["Description"].gsub!(/<.*?>/, '')
  		embed.timestamp = Time.at(1558302217)
	end
end
bot.command(:digtaltrends) do |event|
	kasp = NewsTest.cyber_news("15")
	event.channel.send_embed(" ") do |embed|
  		embed.title = kasp["Title"]
  		embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(url:"https://d19y5x8a5fwmz9.cloudfront.net/getasset/2a911514-842e-488e-8a65-10cea6720637/")
  		embed.colour = 0xf20b27
  		embed.url = kasp["Link"]
  		embed.description = kasp["Description"].gsub!(/<.*?>/, '')
  		embed.timestamp = Time.at(1558302217)
	end
end
bot.command(:comodo) do |event|
	kasp = NewsTest.cyber_news("17")
	event.channel.send_embed(" ") do |embed|
  		embed.title = kasp["Title"]
  		embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(url:"https://www.bitrate.co.za/wp-content/uploads/2018/04/comodo-logo-web.png")
  		embed.colour = 0xf20b27
  		embed.url = kasp["Link"]
  		embed.description = kasp["Description"].gsub!(/<.*?>/, '')
  		embed.timestamp = Time.at(1558302217)
	end
end
bot.command(:itsec) do |event|
	kasp = NewsTest.cyber_news("19")
	event.channel.send_embed(" ") do |embed|
  		embed.title = kasp["Title"]
  		embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(url:"https://www.itsecurityguru.org/wp-content/uploads/2018/08/ITSecurityGuru.jpg")
  		embed.colour = 0xf20b27
  		embed.url = kasp["Link"]
  		embed.description = kasp["Description"].gsub!(/<.*?>/, '')
  		embed.timestamp = Time.at(1558302217)
	end
end
bot.command(:computerfruad) do |event|
	kasp = NewsTest.cyber_news("20")
	event.channel.send_embed(" ") do |embed|
  		embed.title = kasp["Title"]
  		embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(url:"https://computerfraud.us/files/2016/11/dorsey-logo-always-ahead.png")
  		embed.colour = 0xf20b27
  		embed.url = kasp["Link"]
  		embed.description = kasp["Description"]
  		embed.timestamp = Time.at(1558302217)
	end
end
bot.command(:tradesec) do |event|
	kasp = NewsTest.cyber_news("21")
	event.channel.send_embed(" ") do |embed|
  		embed.title = kasp["Title"]
  		embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(url:"https://tradesecretslaw.lexblogplatform.com/wp-content/uploads/sites/232/2016/09/blog-icon-logo-220x136.png")
  		embed.colour = 0xf20b27
  		embed.url = kasp["Link"]
  		embed.description = kasp["Description"].gsub!(/<.*?>/, '')
  		embed.timestamp = Time.at(1558302217)
	end
end
bot.command(:avast) do |event|
	kasp = NewsTest.cyber_news("22")
	event.channel.send_embed(" ") do |embed|
  		embed.title = kasp["Title"]
  		embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(url:"http://pluspng.com/img-png/avast-logo-png-open-2000.png")
  		embed.colour = 0xf20b27
  		embed.url = kasp["Link"]
  		embed.description = kasp["Description"].gsub!(/<.*?>/, '')
  		embed.timestamp = Time.at(1558302217)
	end
end
bot.command(:addmeme) do |event, id, link|
	event.respond(Meme.get_file(id.to_s, link.to_s)["Status"].gsub("memes/", ""))
end
bot.command(:lsmeme) do |event|
	event.respond(Meme.dir_list)
end
bot.command(:ucsoft) do |event|
	event.respond("https://software.utica.edu")
end
bot.command(:whois) do |event, user|
	if user == "me"
		a = User_Info.read_file(event.user.id.to_s)
		string = ""
		a.keys.each do |x|
			string += "#{x}: ***#{a[x].to_s}***\n\n".to_s
		end
		event.respond(string)
	else
		uname = User_Info.getidbyalias("0", user)
		a = User_Info.read_file(uname)
		string = ""
		a.keys.each do |x|
			string += "#{x}: #{a[x].to_s}\n\n".to_s
		end
		event.respond(string)
	end
end
bot.command(:add) do |event, value, value2|
	User_Info.custom(event.user.id.to_s, value, value2)
end
bot.run        