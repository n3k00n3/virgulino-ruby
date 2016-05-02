#!/usr/bin/env ruby
require "getoptlong"
require_relative 'src/cypher'
require_relative 'src/stego'

class Virgulino
  def initialize
  end

  public
  def handler
    @opts = GetoptLong.new(
      ["--help",        "-h", GetoptLong::NO_ARGUMENT],
      ["--options",     "-?", GetoptLong::NO_ARGUMENT],
      ["--encrypt",     "-e", GetoptLong::REQUIRED_ARGUMENT],
      ["--decrypt",     "-d", GetoptLong::REQUIRED_ARGUMENT],
      ["--key",         "-k", GetoptLong::REQUIRED_ARGUMENT],
      ["--input",        "-i", GetoptLong::REQUIRED_ARGUMENT],
      ["--output",      "-o", GetoptLong::REQUIRED_ARGUMENT],
      ["--steg",        "-s", GetoptLong::REQUIRED_ARGUMENT],
    )


    @opts.each do |opt, arg|
      case opt
      when "--help"
        RDoc::usage("Usage")

      when "--encrypt"
        @encrypt = true
        @enc_type = arg
        puts "#{arg}"

      when "--decrypt"
        @decrypt = true
        @enc_type = arg
      when "--key"
        @key = arg
      when "--input"
        @input = true
        @input_filepath = arg
        puts "#{arg}"

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
  end

  private
  def usage
    puts "./virgulino [-e/-d <encryption type>] [-m <message>] [-k <key>] [-i <input filepath>] [-o <output filepath>] [-s <steg_type>]"
  end

end

