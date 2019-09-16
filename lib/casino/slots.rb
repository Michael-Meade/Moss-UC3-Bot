class Slots
	def self.slots_items
		["X", "S", "X", "S", "S", "X", "X", "S", "M", "S", "X"].sample(3)
	end
	def self.pick_slots
		sloot = self.slots_items
		case sloot.count("X")
		when 2
			puts "YES"
		when 3
			puts "YES^2"
		end
	end
end

puts Slots.pick_slots
