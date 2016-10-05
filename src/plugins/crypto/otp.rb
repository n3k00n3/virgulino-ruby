require_relative '../abstract_cypher.rb'


class Otp < AbstractCypher

  @@alphabet = ("A".."Z").to_a + ("0".."9").to_a + ("a".."z").to_a

  def initialize(key)
      @key = key
  end

  def encrypt(content)
    i = 0
    while i < content.length
      char = @@alphabet.index(content[i]) + @@alphabet.index(@key[i])
      if char > 62
        char = char % 62
      end
        content[i] = @@alphabet[char]
        i += 1
    end
    content
  end

  def decrypt(content)
    i = 0
    while i < content.length
      char = @@alphabet.index(content[i]) - @@alphabet.index(@key[i])
      if char < 0
        char = char % 62
      end
      content[i] = @@alphabet[char]
      i += 1
    end
    content
  end
end
