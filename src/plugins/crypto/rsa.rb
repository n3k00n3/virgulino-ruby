require_relative '../abstract_cypher'
require 'base64'
class Rsa < AbstractCypher
  def initialize(key)
    @key = key
    @public = nil
    @e = nil
  end

  def encrypt(content)
    generate_keys
    content = content.each_byte.to_a
    i = 0
    while i < content.length
      char = (content[i] ** @e) % @public
      content[i] = char
      i += 1
    end
    content = base64.encode64(content.to_s)
  end

  def decrypt(content)
    #TODO!
  end

  private
  def test_key(number)
    primo = number > 1 ? 1 : 0
    i = 2
    while primo == 1 && i <= Math.sqrt(number)
      primo = 0 if number % i == 0
      i += 1
    end
    primo
  end

  def generate_keys
    public_key
  end

  def public_key
    number_one = rand(1_000_000_000_000_000_000_000_000_000_000..9_999_999_999_999_999_999_999_999_999_999)
    while test_key(number_one) != 1
      number_one += 1
    end
    number_two = rand(1_000_000_000_000_000_000_000_000_000_000..9_999_999_999_999_999_999_999_999_999_999)
    while test_key(number_two) != 1
      number_two += 1
      test_key(number_two)
    end
    public_key_number = number_one * number_two
    fi = (number_one - 1) * (number_two - 1)
    #the number e needs to be > 1 and < fi
    e = rand((fi/2)..(fi-1))
    result_mdc = mdc fi, e
    while result_mdc == 0
      e += 1
      result_mdc = mdc fi, e
    end
    @public = public_key_number
    @e = e
  end

  def private_key
  end

  def mdc(fi, e)
    return fi if e == 0
    return mdc(e, fi % e)
  end

end
