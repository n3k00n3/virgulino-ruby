require_relative '../abstract_cypher'

class Adfgvx < AbstractCypher
  def initialize(key)
    @key =  key
  end

  def encrypt(content)
    content.upcase!
    @encoded = String.new
    alphabet = ("A".."Z").to_a + ("0".."9").to_a
    content.each_char do | x |
      num = alphabet.index(x)
      first_column(num)
      second_column(num)
    end
    @encoded
  end

  def decrypt(content)
    #decrypt
  end

  private

  def first_column(num)
    case num
      when 0, 1, 2, 3, 4, 5
        @encoded << 'a'.upcase
      when 6, 7, 8, 9, 10, 11
        @encoded << 'd'.upcase
      when 12, 13, 14, 15, 16, 17
        @encoded << 'f'.upcase
      when 18, 19, 20, 21, 22, 23
        @encoded << 'g'.upcase
      when 24, 25, 26, 27, 28, 29
        @encoded << 'v'.upcase
      when 30, 31, 32, 33, 34, 35
        @encoded << 'x'.upcase
    end
  end

  def second_column(num)
    case num
      when 0, 6, 12, 18, 24, 30
        @encoded << 'A'
      when 1, 7, 13, 19, 25, 31
        @encoded << 'D'
      when 2, 8, 14, 20, 26, 32
        @encoded << 'F'
      when 3, 9, 15, 21, 27, 33
        @encoded << 'G'
      when 4, 10, 16, 22, 28, 34
        @encoded << 'V'
      when 5, 11, 17, 23, 29, 35
        @encoded << 'X'
    end
  end
end
