require 'json'
require 'time'
require 'httparty'
def kill
	system("killall -9 proxy")
end
def clear_backup
	system(">backup.html")
end
def save_backup(g)
	f = File.open("backup.hmtl", "a")
	f << g
	f.close 
end
def get_new_url
	i = 0
	g = HTTPary.get("https://dark.fail/empire")
	save_backup(g)
end
def get_current_url
	read      = File.read("config3.json")
	last_log  = read["target"]
end
i = 0
File.readlines("backup.html").each do |b|
	if i == 1
		@code = b.gsub("<code>", "").gsub("</code>", "").gsub("http://", "").strip()
		break
	end
	if b.match('<td class="url status1"')
		i = 1
	end
end

if not @code.include?(get_current_url)
	time = Time.new
	File.open("config3.json", "w") {|file| file.truncate(0) }
	f    = File.open("cofnig3.json", "w")
	read['target'] = @code.gsub("\n", "")
	f    << JSON.pretty_generate(read)
	f.close
end
clear_backup
system("bash test.sh")