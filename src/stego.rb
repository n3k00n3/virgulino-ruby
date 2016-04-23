require_relative 'plugins/abstract_stego.rb'
Dir[File.dirname(__FILE__) + '/plugins/stego/*.rb'].each {|file| require_relative file }

class Stego < AbstractStego
    def initialize(type, filename)
        raise ArgumentError.new('[!!] no filename provided [!!]') if filename == nil
        @filename = filename 
        set_type(type)
    end
 
    public 
    def hide(content)
        @instance.hide(content)
    end

    def unhide
        @instance.unhide
    end

    private
    def set_type(type) 
        begin
            @instance = eval(type).new(@filename)
            raise if !@instance.kind_of? AbstractStego
        rescue 
            raise StandardError.new('[!!] Invalid stego type or class doesn\'t inherit from AbstractStego [!!]')
        end
    end
end
