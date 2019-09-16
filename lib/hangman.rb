require 'random-word'
require 'json'
require 'fileutils'
class HangMan
    FileUtils.mkdir_p "hangman/"  unless File.exists?("hangman/")
    def check_exist
        if not File.exists?("hangman/0.json")
            self.get_word
        end
    end
	def get_word
		word = RandomWord.nouns.next
		f = File.open("hangman/0.json", "a")
		f.write(JSON.pretty_generate({"word" => word,
                                      "correct letters" => [],
                                      "wrong letters"   => []}))
        f.close
	end
	def add_already_guessed(letter)
		read = File.read("hangman/0.json")
    	a = JSON.parse(read)
    	f = File.open("hangman/0.json", "w")
    	a["wrong letters"] << letter 
    	f.write(JSON.pretty_generate(a))
    	f.close
	end
	def add_correct_letter(letter)
		read = File.read("hangman/0.json")
    	a = JSON.parse(read)
    	f = File.open("hangman/0.json", "w")
    	a["correct letters"] << letter 
    	f.write(JSON.pretty_generate(a))
    	f.close
	end
	def check_letter(letter)
		read = File.read("hangman/0.json")
    	a = JSON.parse(read)
    	if a["word"].include?(letter)
    		self.add_correct_letter(letter)
    		s = { "Letter" => "#{letter} was found in the word"}
    	else
    		self.add_already_guessed(letter)
    		s = {"Letter" => "#{letter} was not found :("}
    	end
	end
    def game(letter)
        self.check_exist
        self.check_letter(letter)
    end
    def display
        read = File.read("hangman/0.json")
        a = JSON.parse(read)
        word = a["word"].gsub("_", "")
        wordCount = a["word"]
        puts wordCount.length
    end
end
module Hang
    class << self
        def game_play(letter)
            c = HangMan.new
            puts c.display
            c.game(letter)
        end
    end
end

Hang.game_play("a")