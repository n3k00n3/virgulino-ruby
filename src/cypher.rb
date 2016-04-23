require_relative 'plugins/abstract_cypher'

=begin
 @note: Loading plugin classes.
=end
Dir[File.dirname(__FILE__) + '/plugins/crypto/*.rb'].each {|file| require_relative file }


class Cypher < AbstractCypher
    attr_accessor :type
    attr_accessor :key

    def initialize(type, key)
        @key = key if key != nil
        set_type(type)

    end

    private
    def set_type(type)
       begin
          @instance = eval(type).new(@key)
          raise if !(@instance.kind_of? AbstractCypher)
       rescue
           raise ArgumentError.new('Invalid cypher type or class doesn\'t inherit from AbstractCypher')        
       end
    end

    public
    def encrypt(message)
        @instance.encrypt(message)
    end

    def decrypt(encrypted)
        @instance.decrypt(encrypted)
    end
end
