require_relative '../abstract_cypher'

class Xor < AbstractCypher
  def initialize(key)
    @key = key
  end

  def encrypt(content)
    @key = key_match(content)
    i = 0
    while i < content.length
      xor = @key[i].codepoints.first ^ content[i].codepoints.first
      content[i] = xor.chr
      i += 1
    end
    content
  end

  def decrypt(content)
    @key = key_match(content)
    i = 0
    while i < content.length
      xor = content[i].codepoints.first ^ @key[i].codepoints.first
      content[i] = xor.chr
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
