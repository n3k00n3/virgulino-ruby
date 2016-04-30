require_relative '../abstract_cypher'


class Vigenere < AbstractCypher

    def initialize(key)
      @key = key
    end

    def encrypt(content)
      @key = keyMatch(content)
      @key.upcase!
      content.upcase!
      i = 0
      while i < content.length
        j = @key[i].codepoints.first + content[i].codepoints.first
        j -= 65
        char = j - 26
        if char < 65
          char += 26
        end
        content[i] = char.chr
        i += 1
      end
      content
    end

    def decrypt(content)
      @key = keyMatch(content)
      @key.upcase!
      content.upcase!
      i = 0
      while i < content.length
        j = content[i].codepoints.first - @key[i].codepoints.first
        j += 65
        char = j + 26
        if char > 90
          char -= 26
        end
        content[i] = char.chr
        i += 1
      end
      content
    end

    private
    def keyMatch(content)
      if @key.length < content.length
        i = 0
        while @key.length < content.length
        @key << @key[i]
        i += 1
        end
      elsif @key.length > content.length
        while @key.length > content.length
          @key.chop!
        end
      end
      return @key
    end
end
