require_relative '../abstract_cypher.rb'

module Cypher_Consts
  ASCII_TABLE_BEGINNING = 31
  ASCII_TABLE_ENDING = 127
end

class Ceasar < AbstractCypher
  include Cypher_Consts

  def initialize(key=1)
    if !(key.is_a? Integer)
      key = key.to_i
    end
    raise ArgumentError.new('[!!] Invalid Key [!!]') if !(key.is_a? Integer) and key > 0
    @key = key
  end

  public
  def encrypt(content)
    raise ArgumentError.new('[!!] Invalid content [!!]') if content == nil or !(content.is_a? String)

    for i in 0..content.length-1
      char = content[i].codepoints.first + @key
      if char > ASCII_TABLE_ENDING
        char = ((ASCII_TABLE_ENDING-1) - char) + ASCII_TABLE_BEGINNING
      end
      content[i] = char.chr
    end
  end

  def decrypt(content)
    raise ArgumentError.new('[!!] Invalid content [!!]') if content == nil or !(content.is_a? String)

    for i in 0..content.length-1
      char = content[i].codepoints.first
      if char == 8
        content[i] = 10.chr
        next
      end
      char = char - @key
      if char < ASCII_TABLE_BEGINNING
        char = (ASCII_TABLE_ENDING-1) - (ASCII_TABLE_BEGINNING - char)
      end
      content[i] = char.chr
    end
  end
end
