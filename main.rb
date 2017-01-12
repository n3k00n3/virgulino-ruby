#!/usr/bin/env ruby
require_relative 'src/cypher'
require_relative 'src/stego'

# message and key to be used on encryption process
message="amor"
key = "odio"

#instanciating a Cypher object based on Ceasar plugin.
v = Cypher.new("Xor", key)

#instanciating a Stego object based on Txt plugin.
#s = Stego.new("Txt", "teste")

#CRYPTO
#encrypting message
puts v.encrypt(message)

#STEGNO
#hiding message
#s.hide(message)

#unhiding message
#message = s.unhide

#CRYPTO#
#decrypting message
message="DgkGHQ=="
puts v.decrypt(message)

#puts message
#printing it
#puts "If virgulino's plugins are working right you should see \'ABC\' above:\n#{message}"
