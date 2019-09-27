require 'fileutils'
require 'json'
class Upload
	FileUtils.mkdir_p "uploads/"  unless File.exists?("uploads/")
    def self.add_file(id, url, name)
    	if File.exists?("uploads/#{id}.json")
	    	fileRead = File.read("uploads/#{id}.json")
	    	a = JSON.parse(fileRead)
	    	f = File.open("uploads/#{id}.json", "w")
	    	a[name] = url
	    	f.write(JSON.pretty_generate(a))
	    	f.close
    	else
	    	f = File.open("uploads/#{id}.json", "w")
			f.write(JSON.pretty_generate({name => url}) )
			f.close
	    end
    end
end


#Upload.add_file("1", "http://google.com", "d")