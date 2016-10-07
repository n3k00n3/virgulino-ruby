require_relative '../abstract_cypher'

class Rfence < AbstractCypher
  def initialize(key)
    begin
      @key = key.to_s.to_i
    rescue
      raise ArgumentError.new('[!!] Invalid Key [!!] Key value(' << @key << ') must be > 0 !!') if @key <= 0
    end
  end

  def encrypt(content)
    b = Array.new
    c = Array.new
    content = content.chars.to_a
    for i in 0..content.length
      b << content[i] if i % 2 == 1
      c << content[i] if i % 2 == 0
    end
    content = c.join + b.join
  end

  def decrypt(content)
    #to do
  end
end
