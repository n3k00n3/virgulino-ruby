require_relative '../abstract_stego'

module TxtConsts
  TAG = 8
end

class Txt < AbstractStego
  include TxtConsts

  @content = ''
  @source = ''
  def initialize
  end

  def hide(content, input, output)
    content = escape(to_bin(content))
    flaged_content = 32.chr
    flaged_content << TAG.chr << content << TAG.chr

    full_content = from_file(input)
    full_content << flaged_content

    to_file(full_content, output)
  end

  def unhide(input)
    content = from_file(input)

    unhidden = ''
    hidden = ''
    tag_open = false
    content.bytes.each do |c|
      if tag_open == true
        if c == TAG
          unhidden << to_string(descape(hidden)) << 8
          hidden = ''
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

  # String to bin
  def to_bin(content)
    bin = ''
    content.bytes.each do |x|
      bin += '0' if x < 0x40
      bin += x.to_s(2)
    end
    bin
  end

  # bin to string
  def to_string(content)
    newstr = ''
    counter = 0
    final = ''

    content.each_char do |x|
      newstr += x
      counter += 1
      if counter == 7
        final += newstr.to_i(2).chr
        counter = 0
        newstr = ''
      end
    end
    final
  end

  def escape(content)
    content.gsub!(/[10]/, '1' => "\t", '0' => ' ')
  end

  def descape(content)
    content.gsub!(/[\t ]/, "\t" => '1', ' ' => '0')
  end

  def from_file(filename)
    begin
      fd = File.open(filename, 'r')
      content = fd.read
      fd.close
    rescue SystemCallError
      raise StandardError.new('[!!] Unable to read from file []!!')
    end

    content
  end

  def to_file(content, filename)
    begin
      fd = File.open(filename, 'w')
      fd.write(content)
      fd.close
    rescue SystemCallError
      raise StandardError.new('[!!] Unable to write to file [!!]')
    end
  end
end
