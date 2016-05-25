require_relative '../abstract_cypher.rb'

module Cypher_Consts
  ASCII_TABLE_BEGINNING = 31
  ASCII_TABLE_ENDING = 127
end

class Caesar < AbstractCypher
    include Cypher_Consts

    def initialize(key)
        begin
            @key = key.to_s.to_i 
        rescue
            raise ArgumentError.new('[!!] Invalid Key [!!] Key value(' << @key << ') must be > 0 !!') if @key <= 0
        end
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
