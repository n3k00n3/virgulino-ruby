require_relative 'plugins/abstract_cypher'

=begin
 @note: Loading plugin classes.
=end
Dir[File.dirname(__FILE__) + '/plugins/crypto/*.rb'].each { |file| require_relative file }


class Cypher < AbstractCypher
  attr_reader :config_filepath

  def initialize(type, key, config_filepath = nil)
    @config_filepath = config_filepath
    @key = key if key != nil
    set_type(type)

  end

    private
    def set_type(type)
       begin
          type.capitalize!
          @instance = (@config_filepath.nil?) ? eval(type).new(@key) : eval(type).new(@key, @config_filepath)
          raise if !(@instance.kind_of? AbstractCypher)
       rescue
           raise ArgumentError.new('[' << type << '] Invalid cypher type or class doesn\'t inherit from AbstractCypher')        
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
