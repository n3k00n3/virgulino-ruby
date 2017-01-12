require_relative '../abstract_cypher'
require 'base64'

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
    content = Base64.encode64(content)
  end

  def decrypt(content)
    content = Base64.decode64(content)
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
