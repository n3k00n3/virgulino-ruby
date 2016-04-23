require_relative '../abstract_stego'

module TxtConsts
    TAG  = 8
end

class Txt < AbstractStego
    include  TxtConsts

    @content = ""
    @filename= ""
    def initialize(filename)
        @filename = filename
    end

    public 
    def hide(content)
        content = escape(to_bin(content))
        flaged_content = '\x20'
        flaged_content << TAG.chr << content << TAG.chr
        begin
            fd = File.open(@filename, 'a')
            fd.puts(flaged_content)
            fd.close
        rescue SystemCallError
            raise StandardError.new('[!!] Unable to write to file [!!]')
        end
    end

    def unhide
        begin
            fd = File.open(@filename, "r")
            content = fd.read
            fd.close
        rescue
            raise StandartError.new('[!!] Unable to read from file [!!]')
        end
        unhidden = ""
        hidden = ""
        tag_open = false
        content.bytes.each do | c |
            if tag_open == true
                if c == TAG
                    unhidden << to_string(descape(hidden)) << 8
                    hidden = ""
                    tag_open = false
                end
                hidden << c if tag_open == true
                next
            end

            if c == TAG
                tag_open = true
                next
            end
       end
        unhidden
    end

    private
    #String to bin
    def to_bin(content)
        bin = ""
        content.bytes.each do |x| 
            bin += '0' if x < 0x40
            bin += x.to_s(2)
        end
        bin
    end

    #bin to string
    def to_string(content)
        newstr = ""
        counter = 0
        final = ""
        
        content.each_char do |x| 
            newstr += x
            counter += 1
            if counter == 7
                final += (newstr.to_i (2)).chr
                counter = 0
                newstr = ""
            end
        end
        final
    end

    def escape(content)
        content.gsub!(/[10]/, "1" => "\t", "0" => " ")
    end
 
    def descape(content)
        content.gsub!(/[\t ]/, "\t" => "1", " " => "0")
    end
end
