require_relative 'plugins/abstract_stego.rb'
Dir[File.dirname(__FILE__) + '/plugins/stego/*.rb'].each { |file| require_relative file }

class Stego < AbstractStego
  def initialize(type, resource=nil)
    #raise ArgumentError.new('[!!] no filename provided [!!]')
    @resource = resource

    set_type(type)
  end

  public
  def hide(content, input_file, output_file)
    @instance.hide(content, input_file, output_file)
  end

  def unhide(input_file)
    @instance.unhide(input_file)
  end

  private
  def set_type(type)
    begin
      @instance = !(@resource.nil?) ? eval(type).new(@resource) : eval(type).new()
      raise if !@instance.kind_of? AbstractStego
    rescue
      raise StandardError.new('[!!] Invalid stego type or

 class doesn\'t inherit from AbstractStego [!!]')
    end
  end
end
