require_relative 'utils'
require 'json'
class FixList
	Utils.create_dir("fix")
	def self.get_id
		read  = File.read("fix/315264930951462913.json")
		read2 = JSON.parse(read)
		id = read2.keys.last.to_i
		id +=1
	end
	def self.add(item)
		if File.exists?("fix/315264930951462913.json")
			id = get_id
	    	fileRead = File.read("fix/315264930951462913.json")
	    	a = JSON.parse(fileRead)
	    	f = File.open("fix/315264930951462913.json", "w")
	    	a[id] = item
	    	f.write(JSON.pretty_generate(a))
	    	f.close
    	else
	    	f = File.open("fix/315264930951462913.json", "w")
			f.write(JSON.pretty_generate({"0" => item}) )
			f.close
	    end
	end
	def self.remove(values)
		file_read = File.read("fix/315264930951462913.json")
		read = JSON.parse(file_read)
		i = 0
		read.each do |key, value|
			#puts i
			#puts key
			#puts key
			if i.to_i == values.to_i
				read.delete(key)
			end
			i+=1
		p read
		end
		#p read
		#f = File.open("fix/315264930951462913.json", "w")
		#f.write(JSON.pretty_generate(read))
		#f.close
	end
	# take me to the comic shop
end
=begin
def self.remove(value)
		file_read = File.read("fix/315264930951462913.json")
		read = JSON.parse(file_read)
		fileRead.each { |del| del.delete(value) }
		f = File.open("fix/315264930951462913.json", "w")
		f.write(fileRead)
		end
	end
=end
=begin
FixList.add("bob")
FixList.add("JLI")
FixList.add("taco")
FixList.add("smith")
=end
FixList.remove(3)
#FixList.add("Jake")
#FixList.add("smith")
#FixList.list

#puts Utils.create_list("fix/315264930951462913.json")