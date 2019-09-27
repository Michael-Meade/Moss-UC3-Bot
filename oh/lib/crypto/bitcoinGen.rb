require 'openssl'
require 'ecdsa'
require 'securerandom'
require 'base58'
require 'colorize'
require 'fileutils'
class BitcoinAddressGenerator
  ADDRESS_VERSION = '00'
  FileUtils.mkdir_p "wallets/"  unless File.exists?("wallets/")
  def address
    address = @address
  end
  def generate_address
    # Bitcoin uses the secp256k1 curve
    curve = OpenSSL::PKey::EC.new('secp256k1')
    curve.generate_key
    private_key_hex = curve.private_key.to_s(16)
    public_key_hex  = curve.public_key.to_bn.to_s(16)
    publicKeyHash = public_key_hash(public_key_hex)
    @address = generate_address_from_public_key_hash(public_key_hash(public_key_hex))
    return @address, private_key_hex, publicKeyHash, public_key_hex
  end

  def generate_address_from_public_key_hash(pub_key_hash)
    pk = ADDRESS_VERSION + pub_key_hash
    encode_base58(pk + checksum(pk)) # Using pk here, not pub_key_hash
  end

  def int_to_base58(int_val, leading_zero_bytes=0)
    alpha = "123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz"
    base58_val, base = '', alpha.size
    while int_val > 0
      int_val, remainder = int_val.divmod(base)
      base58_val = alpha[remainder] + base58_val
    end
    base58_val
  end

  def encode_base58(hex)
    leading_zero_bytes = (hex.match(/^([0]+)/) ? $1 : '').size / 2
    ("1"*leading_zero_bytes) + int_to_base58( hex.to_i(16) )
  end

  def checksum(hex)
    sha256(sha256(hex))[0...8]
  end

  def rmd160(hex)
    Digest::RMD160.hexdigest([hex].pack("H*"))
  end

  def sha256(hex)
    Digest::SHA256.hexdigest([hex].pack("H*"))
  end

  def public_key_hash(hex)
    rmd160(sha256(hex))
  end
end
module Vanity
  class << self
    BTC = BitcoinAddressGenerator.new()
    def writeToFile(address, fileToWrite=nil)
      if fileToWrite != nil
        createDir(fileToWrite)
        f = File.open("wallets/" + fileToWrite + "/" + address[0] + ".txt", "a")
        f << "Address: "      + address[0].to_s      + "\n"
        f << "PublicKeyHex: " + address[3].to_s      + "\n"
        f << "PublicKey: "    + address[2].to_s      + "\n"
        f << "privateKey: "   + address[1].to_s      + "\n"
        f.close
      else
        f = File.open("wallets/" + address[0] + ".txt", "a")
        f << "Address: "      + address[0].to_s      + "\n"
        f << "PublicKeyHex: " + address[3].to_s      + "\n"
        f << "PublicKey: "    + address[2].to_s      + "\n"
        f << "privateKey: "   + address[1].to_s      + "\n"
        f.close
      end
    end
    def regex(regex, fileToWrite=nil)
      while true
        address = BTC.generate_address
        if address[0].match(regex)
          writeToFile(address, fileToWrite)
          puts "Address found: #{address[0]}!"
          break
        end
      end
    end
    def regexFiles(filetoRead, count, fileToWrite=nil)
      i = 0
      regex = File.readlines(filetoRead).to_a
      while i < count.to_i
        address = BTC.generate_address
        regex.each do |a|
          puts address[0]
          puts "\n"
          if address[0].match(a)
            puts "Amount Found: " + i.to_s 
            puts "Address found: #{address[0]}!".green
            writeToFile(address, fileToWrite)
            i+=1
          end
        end
      end
    end
    def massGenerate(count, fileToWrite=nil)
      puts fileToWrite
      i = 0
      while i < count.to_i
        address = BTC.generate_address
        writeToFile(address, fileToWrite)
        i+=1
      end
    address = address[0]
    end
  end
end
