require_relative '../abstract_cypher'


class Vigenere < AbstractCypher

    def initialize(key)
      @key = key
    end

    def keyMatch(content)
    key = @key
    if key.length < content.length
      i = 0
      while key.length < content.length
      key << key[i]
      i += 1
      end
    else key.length > content.length
      while key.length > content.length
        key.chop!
      end
      $key = key
    end

    def encrypt(content)
      key = keyMatch(content)
	  key.upcase!
      key = key.each_byte.to_a
      content.upcase!
      content = content.each_byte.to_a
      i = 0
      while i < content.length
        j = key[i] + content[i]
        j = j - 65
        char = j - 26
        if char < 65
          char = char + 26
        end

        content[i] = char.chr
        i += 1
      end
      content = content.join
    end

  def decrypt(content)
	  key = keyMatch(content)
	  key.upcase!
      content.upcase!
      key = key.each_byte.to_a
      content = content.each_byte.to_a
      i = 0
      while i < content.length
        j = content[i] - key[i]
        j = j + 65
        char = j + 26
        if char > 90
          char = char - 26
        end
	    content[i] = char.chr
        i += 1
      end
	  content = content.join
  end
end
