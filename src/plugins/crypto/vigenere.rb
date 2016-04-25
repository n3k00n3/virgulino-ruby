require_relative '../abstract_cypher'


class Vigenere < AbstractCypher

    def initialize(key)
      @key = key
    end

    public
    def encrypt(content)
      key = @key
	  key.upcase!
      key = key.each_byte.to_a
      content.upcase!
      content = content.each_byte.to_a
      i = 0
      na = 65
      l = 26
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
      puts content
    end

  def decrypt(content)
	  key = @key
	  key.upcase!
      content.upcase!
      key = key.each_byte.to_a
      content = content.each_byte.to_a
      i = 0
      na = 65
      l = 26
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
      puts content
  end
end
