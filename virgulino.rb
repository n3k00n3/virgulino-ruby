#!/usr/bin/env ruby
require "getoptlong"
require_relative 'src/cypher'
require_relative 'src/stego'

class Virgulino
  def initialize
  end

  public
  def options_handler()
    @opts = GetoptLong.new(
      ["--help",        "-h", GetoptLong::NO_ARGUMENT],
      ["--options",     "-?", GetoptLong::NO_ARGUMENT],
      ["--encrypt",     "-e", GetoptLong::REQUIRED_ARGUMENT],
      ["--decrypt",     "-d", GetoptLong::REQUIRED_ARGUMENT],
      ["--key",         "-k", GetoptLong::REQUIRED_ARGUMENT],
      ["--message",     "-m", GetoptLong::REQUIRED_ARGUMENT],
      ["--input",       "-i", GetoptLong::REQUIRED_ARGUMENT],
      ["--output",      "-o", GetoptLong::REQUIRED_ARGUMENT],
      ["--steg",        "-s", GetoptLong::REQUIRED_ARGUMENT],
    )

    @optn = 0
    @opts.each do |opt, arg|
      @optn += 1
      case opt
      when "--options"
        help()
      when "--help"
        help()
      when "--encrypt"
        @encrypt = true
        @enc_type = arg

      when "--decrypt"
        @decrypt = true
        @enc_type = arg
      when "--key"
        @key = arg
      when "--message"
        @message = String.new(arg)
      when "--input"
        @input = true
        @input_filepath = arg

      when "--output"
        @output = true
        @output_filepath = arg

      when "--steg"
        @steg = true
        @steg_type = arg

      else
        usage()
      end
    end

    usage() if @optn == 0

    where_everthing_actually_happens()
  end

  private
  def usage()
    puts ("./virgulino [-e/-d <encryption type>] [-m <message>] [-k <key>] [-i <input filepath>] [-o <output filepath>] [-s <steg_type>]")
  end

  def help()
    puts "HELP (not implemented)"
  end

  def write_to_file()

  end

  def where_everthing_actually_happens()
    @enc_type = @enc_type.capitalize() if @encrypt or @decrypt
    @steg_type = @steg_type.capitalize() if @steg
    @key = @key.to_i()


    @cypher = Cypher.new(@enc_type, @key) if @encrypt and @key != nil
    puts (@message)
    @cypher.encrypt(@message)
    puts @message

  end
end

