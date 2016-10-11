require_relative '../abstract_cypher'

class rsa < AbstractCypher
  def initialize(key)
    @key = key
  end

  def encrypt(content)
    #TODO!
  end

  def decrypt(content)
    #TODO!
  end

  private
  def test_key(number)
    number > 1 ? primo = 1 : primo = 0
    i = 2
    while primo == 1 && i <= number / 2
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
      number_one = number_one + 1
    end
    number_two = rand(1_000_000_000_000_000_000_000_000_000_000..9_999_999_999_999_999_999_999_999_999_999)
     while test_key(number_two) != 1
       number_two = number_two + 1
     end
    private_key_number = number_one * number_two
    fi = (number_one - 1) * (number_two - 1)
    e = mdc fi
  end

  def private_key
  end

  def mdc(fi)

end
