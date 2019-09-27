require "whois"
require 'whois-parser'
record = Whois.whois("google.it")
# => #<Whois::Record>

a = record.parser
admin   = a.admin_contacts.first
bb =  a.registrant_contacts.first
puts admin

d = {"domain" => a.domain, 
	 "status" => a.status, 
	 "created" => a.created_on, 
	 "updated_on" => a.updated_on, 
	 "expires_on" => a.expires_on,
	 "registrar"  => a.registrar,
	 "registrant_contacts" => a.registrant_contacts,
	 "admin_contacts"      => a.admin_contacts,
	 "technical_contacts"  => a.technical_contacts,
	 "nameservers"         => [a.nameservers.each {|pp| pp}]}
#puts d