require_relative '../abstract_cypher.rb'


class Otp < AbstractCypher

  @@alphabet = ("A".."Z").to_a + ("0".."9").to_a + ("a".."z").to_a

  def initialize(key)
      @key = key
  end

  def encrypt(content)
    @key = rand_key(content) if @key == nil
    if @key == nil
      @key = rand_key(content)
    else
      @key = key_match(content)
    end

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
    raise ArgumentError.new('[!!] You need to choose a Key !!') if @key == nil
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

  def rand_key(content)
      @key = @@alphabet.sample(content.length)
  end
end
