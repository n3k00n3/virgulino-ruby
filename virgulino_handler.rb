require 'getoptlong'
require_relative 'src/cypher'
require_relative 'src/stego'

class Virgulino
  def initialize
  end

  def options_handler
    @opts = GetoptLong.new(
      ['--help',        '-h', GetoptLong::NO_ARGUMENT],
      ['--options',     '-?', GetoptLong::NO_ARGUMENT],
      ['--encrypt',     '-e', GetoptLong::REQUIRED_ARGUMENT],
      ['--decrypt',     '-d', GetoptLong::REQUIRED_ARGUMENT],
      ['--key',         '-k', GetoptLong::REQUIRED_ARGUMENT],
      ['--message',     '-m', GetoptLong::REQUIRED_ARGUMENT],
      ['--input',       '-i', GetoptLong::REQUIRED_ARGUMENT],
      ['--output',      '-o', GetoptLong::REQUIRED_ARGUMENT],
      ['--steg',        '-s', GetoptLong::REQUIRED_ARGUMENT]
    )

    @optn = 0
    @opts.each do |opt, arg|
      @optn += 1
      case opt
      when '--options'
        help

      when '--help'
        help

      when '--encrypt'
        @encrypt = true
        @enc_type = arg

      when '--decrypt'
        @decrypt = true
        @enc_type = arg

      when '--key'
        @key = String.new(arg)

      when '--message'
        @message = String.new(arg)

      when '--input'
        @input = true
        @input_filepath = arg

      when '--output'
        @output = true
        @output_filepath = arg

      when '--steg'
        @steg = true
        @steg_type = arg

      else
        usage
      end
    end

    usage if @optn == 0

    where_everthing_actually_happens
  end

  private

  def usage
    puts './virgulino [-e/-d <encryption type>] [-m <message>] [-k <key>] [-i <input filepath>] [-o <output filepath>] [-s <steg_type>]'
    exit
  end

  def help
    puts 'HELP (not implemented)'
    exit
  end

  def where_everthing_actually_happens
    @enc_type = @enc_type.capitalize if @encrypt || @decrypt
    @steg_type = @steg_type.capitalize if @steg

    @cypher = Cypher.new(@enc_type, @key) if (@encrypt || @decrypt) && !@key.nil?

    if @encrypt
      @cypher.encrypt(@message)
      if @steg && !@output_filepath.nil?
        @stego = Stego.new(@steg_type)
        @stego.hide(@message, @input_filepath, @output_filepath)

      elsif @steg and @output_filepath.nil?
        puts '[!!] Output Filepath missing [!!]'
        exit
      else
        puts '[!!] Stegnography flag not setted [!!]'
        exit
      end

    elsif @decrypt
      if @input_filepath.nil?
        puts '[!!] No input file provided [!!]'
        exit
      end
      if @steg.nil?
        puts '[!!] No stego setted [!!]'
        exit
      end

      @stego = Stego.new(@steg_type)
      @message = @stego.unhide(@input_filepath)
      @cypher.decrypt(@message)
      !@output_filepath.nil? ? save : show

    else
      puts '[!!] Please set one of the flags [encrypt/decyrpt] [!!]'
      exit
    end
  end

  def save
    begin
      fd = File.open(@output_filepath, 'w')
      fd.write(@message)
      fd.close
    rescue SystemCallError
      raise StandardError.new('[!!] Unable to write to the file [!!]')
    end
  end

  def show
    puts "\nBEGIN MESSAGE\n\n" << @message << "\n\nEND MESSAGE\n"
  end
end
