require_relative '../abstract_cypher'

class Vigenere < AbstractCypher

    def initialize(key)
        @key = key
    end

    public
    def encrypt(content)
        puts "Callint encrypt: #{content}"
    end

    def decrypt(content)
        puts "Callint decrypt: #{content}"
        content
    end
end
