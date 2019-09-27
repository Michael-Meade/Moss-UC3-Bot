require 'whois'
require 'whois-parser'
#c = Whois::Client.new
#puts c.lookup("google.com")
#r = Whois.whois("wack.org")
# => #<Whois::Record ...>



puts Whois.available?("hackex.net")