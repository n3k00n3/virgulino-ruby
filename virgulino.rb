#!/usr/bin/ruby
# encoding: utf-8

class Caesar
    
    def initialize(shift)
        alphabet = (("A".."Z").to_a + ("a".."z").to_a).join
        i = shift % alphabet.size
        @decrypt = alphabet
        @encrypt = alphabet[i..-1] + alphabet[0...i]
    end    

    def encrypt(string)
        string.tr(@decrypt, @encrypt)
    end

    def decrypt(string)
        string.tr(@encrypt, @decrypt)
    end
end

class String
    def green; "\033[1;32m#{self}\033[0m" end
    def red;"\033[1;31m#{self}\033[0m" end
    def yellow;"\033[0;33m#{self}\033[0m" end	
end

def splash()
    puts """
        ╔═══════════════════════════════════════════════════╗
        ║         __                    __ __               ║
        ║ .--.--.|__|.----.-----.--.--.|  |__|.-----.-----. ║
        ║ |  |  ||  ||   _|  _  |  |  ||  |  ||     |  _  | ║
        ║  \\___/ |__||__| |___  |_____||__|__||__|__|_____| ║
        ║                 |_____|                           ║
        ║                                                   ║
        ║ Virgulino v0.1                                    ║
        ║ LampiaoSEC - Security Research Group              ║
        ║ #lampiaosec at OFTC                               ║
        ║ https://lampiaosec.github.io                      ║
        ║                                                   ║
        ╚═══════════════════════════════════════════════════╝
	""".green
end

def menu()
    puts "What do you wanna do?".green
    puts "[e - to encrypt]".green
    puts "[d - to decrypt]".green
    puts "[q - to quit]".green
    answer = gets.chomp
    
    if (answer == "e")
        puts "[c - Caeser Cypher]".red
        puts "[v - Vignere Cypher]".red
        answer2 = gets.chomp
        if (answer2 == "c")
            puts "What key do you wanna?".red
                $key = gets.chomp
                puts "Write whatever text you want to encrypt and press enter.".green
                $text = gets.chomp
                caesar_cypher = Caesar.new($key.to_i)
                $encoded = caesar_cypher.encrypt($text)
                hide()
        elsif (answer2 == "v")
            puts "Write whatever text you want to encrypt and press enter.".green
            exit()
        end
    elsif answer == "d"
        puts "[c - Caeser Cypher]".red
        puts "[v - Vignere Cypher]".red
        answer2 = gets.chomp
        if answer2 == "c"
            print "insert the key to decrypt: ".red
            $key = gets.chomp
            display()
        end
    else 
        puts "See you later!!!".green
    end     
    exit()
end

def bin_to_s(str)
    newstr = ""
    counter = 0
    final = ""

    str.each_char do |x| 
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

def hide()
    $text2= ""     
   #convert string to bin
    $encoded.bytes.each do |x| 
        if (x < 0x40) 
            $text2 += '0'
        end
            $text2 += x.to_s(2)
    end
    #convert bin to spaces and tabs
    $text2.gsub!(/[10]/, "1" => "\t", "0" => " ")
    f = File.new("virgulino", "w") #make file with stego
    f.write($text2)
    f.close
    puts "Your file is done! It`s name is virgulino.".green
end

def display()
    exist=false
    while exist != true
        print "Enter the encoded filename: ".red
        $file= gets.chomp
           
        if File.exist?("#{$file}")
            exist=true
            $stegofile = File.read("#{$file}")

            #convert spaces/tabs to bin
	  	    $stegofile.gsub!(/[\t]/ , "\t" => "1")
            $stegofile.gsub!(/[ ]/ , "0")
            
            $stegofile = bin_to_s($stegofile)

            #decrypt Caesar   
            caesar_cypher = Caesar.new($key.to_i)
            decoded = caesar_cypher.decrypt($stegofile)
            puts "\n" << decoded
            puts " "
            print "Do you want to save this decrypted file? (y/n): ".green
            answer2 = gets.chomp
            if answer2 == "y"
                print "What should be the output filename?: ".red
                name_file = gets.chomp
          	    f = File.new("#{name_file}", "w")
          	    f.write(decoded)
           	    f.close
                puts "Your file has been created successfuly!".red
            else
            puts "See you!!!".red
            end        
        else
       	   puts (name_file + " was not found.").red
        end
    end
end

splash()
menu()
