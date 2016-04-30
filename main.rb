#!/usr/bin/env ruby
require_relative 'src/cypher'
require_relative 'src/stego'


=begin
    @note: Just a proof of concept that
    stegnography and cryptography plugin 
    archtecture are working just fine.
=end

# message and key to be used on encryption process
message="LBMCOCJMSSDCX"
key = "limaolimaolim"

#instanciating a Cypher object based on Ceasar plugin.
v = Cypher.new("Vigenere", key)

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
puts v.decrypt(message)

#puts message
#printing it
#puts "If virgulino's plugins are working right you should see \'ABC\' above:\n#{message}"
