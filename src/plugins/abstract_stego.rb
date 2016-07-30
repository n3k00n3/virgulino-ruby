require_relative 'abstract'

class AbstractStego
  include Abstract

  def initialize
    abstract_exception
  end

  abstract_methods :hide, :unhide
end
