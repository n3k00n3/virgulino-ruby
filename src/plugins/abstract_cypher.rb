require_relative 'abstract'

class AbstractCypher
  include Abstract

  def initialize
    Abstract_exception
  end

  abstract_methods :encrypt, :decrypt
end
