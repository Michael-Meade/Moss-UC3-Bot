require 'google_search_results'
require 'json'
#puts JSON.pretty_generate(hash_results)
class Google
	def self.search(q)
		query = GoogleSearchResults.new q: "money"
		hash_results = query.get_hash
		#p hash_results
		#puts JSON.pretty_generate(hash_results)
		puts hash_results[:organic_results]
	end
end

<<<<<<< HEAD
Google.search("s")
=======
#Google.search("s")
>>>>>>> 6c8790b744e3119150b90820a7700ef4e34acc99
