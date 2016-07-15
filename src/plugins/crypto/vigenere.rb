require_relative '../abstract_cypher'

class Vigenere < AbstractCypher
  def initialize(key)
    @key = key
  end

  def encrypt(content)
    @key = key_match(content)
    @key.upcase!
    content.upcase!
    i = 0
    while i < content.length
      j = @key[i].codepoints.first + content[i].codepoints.first
      j -= 65
      char = j - 26
      char += 26 if char < 26
      content[i] = char.chr
      i += 1
    end
    content
  end

  def decrypt(content)
    @key = key_match(content)
    @key.upcase!
    content.upcase!
    i = 0
    while i < content.length
      j = content[i].codepoints.first - @key[i].codepoints.first
      j += 65
      char = j + 26
      char -= 26 if char > 90
      content[i] = char.chr
      i += 1
    end
    content
  end

  private

  def key_match(content)
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
    @key
  end
end
