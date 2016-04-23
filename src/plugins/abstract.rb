require 'active_support/concern'

module Abstract
    extend ActiveSupport::Concern

    included do
        def self.abstract_methods(*methods)
            methods.each  do |method_name|
                define_method method_name do
                    raise NotImplementedError, 'This is an abstract method that must be implemented!'
                end
            end
        end

        def abstract_exception
            raise StandartError.new('[!!] Abstract class [!!]')
        end
    end

end


