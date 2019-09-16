require 'digest'
require 'securerandom'
require 'uri'
require 'base58'
module Encode
	class << self
		def encode_md5(code)
			Digest::MD5.hexdigest(code)
		end
		def encode_sha1(code)
			Digest::SHA1.hexdigest(code)
		end
		def encode_base64(code)
			Base64.encode64(code)
		end
		def decode_base64(code)
			Base64.decode64(code)
		end
		def encode_base54(code)
			SecureRandom.base58
		end
		def decode_bacon(code)
			[code.tr("A", "0").tr("B", "1")].pack("B*")
		end
		def encode_bacon(code)
			code.unpack("B*").first.tr("0", "A").tr("1", "B")
		end
		def encode_binary(code)
			code.unpack("B*")
		end 
		def decode_binary(code)
			[code].pack("B*")
		end
		def encode_hex(code)
			code.each_byte.map { |b| b.to_s(16) }.join
		end
		def hex_decode(code)
			#code.hex
			code.scan(/../).map { |x| x.hex.chr }.join
		end
		def caesar_cipher(string, shift = 1)
			encrypter = ([*('a'..'z')].zip([*('a'..'z')].rotate(shift)) + [*('A'..'Z')].zip([*('A'..'Z')].rotate(shift))).to_h
			string.chars.map { |c| encrypter.fetch(c, c) }
		end
		def url_encode(code)
			 puts URI::parse(code).to_s
		end
		def reverse_string(code)
			code.reverse!
		end
		def xor(key, str)
			str.split(//).collect {|e| [e.unpack('C').first ^ (key.to_i & 0xFF)].pack('C') }.join
		end
		def string_length(code)
			code.length
		end
		def encode_rot13(code, shift)
			code.chars.map do |c| 
				if c.ord.between?('A'.ord, 'M'.ord) || c.ord.between?('a'.ord, 'm'.ord)
					c.ord + shift.to_i
				elsif c.ord.between?('n'.ord, 'z'.ord) || c.ord.between?('N'.ord, 'Z'.ord)
					c.ord - shift.to_i
				else 
					c.ord
				end
			end.map(&:chr).join
		end
		
	end
end
