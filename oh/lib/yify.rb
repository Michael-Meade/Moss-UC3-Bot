require 'httparty'
require 'pp'
a = HTTParty.get("https://yts.am/api/v2/list_movies.json?query_term=batman")
a =  a.parsed_response["data"]["movies"].shift
s = {"Title"   => a["title"],
		     "Year"    => a['year'],
		     "Rating"  => a['rating'],
		     "RunTime" => a['runtime'],
		     "Genre"   => a["genres"],
		     "Summary" => a['summary'],
		     "pic"     => a['large_cover_image'],
		 	 "Torrent" => a['url'],
		 	 "Quality" => a['quality'],
		 	 "Seeds"   => a['seeds'],
		 	 "Peers"   => a['peers'],
		 	 "Size"    => a['size']}
