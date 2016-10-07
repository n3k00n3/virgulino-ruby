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
    a = Array.new
    b = Array.new
    content.chars.to_a
    content.length / 2 % 2 == 0 ? x = content.length / 2 : x = content.length / 2 + 1
    while x < content.length
      a << content[x]
      x += 1
    end
    x / 2 % 2 == 0 ? x = content.length / 2 : x = content.length / 2 + 1
    for i in 0..x
      b << content[i]
      b << a[i]
      while b.length > content.length
        b.pop
      end
    end
    content = b.join
  end
end
