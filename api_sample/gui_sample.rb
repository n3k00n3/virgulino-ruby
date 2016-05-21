#!/usr/bin/env ruby

require "gtk3"
require_relative '../src/cypher'

class FrontEnd < Gtk::Window
    
    @vbox = nil

    @messsage_box = nil
    @message_label = nil

    @endecrypt_box = nil
    @endecrypt_label = nil

    @message_entry_text = nil
    @endecrypted_entry_text = nil
    
    @key_label = nil
    @key_entry = nil

    @crypto_group = nil
    @caesar_radio = nil
    @vigenere_radio = nil

    @ok_button = nil

    @crypto_type = nil
    
    def initialize()
        super
        set_title("PROOF OF CONCEPT")
        set_default_size(440, 170)
        set_resizable(false)
        set_window_position(Gtk::WindowPosition::CENTER)

        signal_connect "destroy" do
            Gtk::main_quit()
        end 

        @crypto_type = "caesar"
        arrange()

    end

    def arrange()
        @vbox = Gtk::Box.new(Gtk::Orientation::VERTICAL, 2)
        @vbox.set_border_width(5)
        add @vbox

        @message_box = Gtk::Box.new(Gtk::Orientation::HORIZONTAL, 2)
        @message_label = Gtk::Label.new("Message")
        @message_entry_text = Gtk::Entry.new()
        
        @vbox.pack_start(@message_box,:expand => false, :fill => false, :padding => 2)
        @message_box.pack_start(@message_label,:expand => false, :fill => false, :padding => 2)
        @message_box.pack_start(@message_entry_text,:expand => true, :fill => true, :padding => 2)

        @endecrypt_box = Gtk::Box.new(Gtk::Orientation::HORIZONTAL, 2)
        @endecrypt_label = Gtk::Label.new("Encrypted")
        @endecrypted_entry_text = Gtk::Entry.new()
        
        @vbox.pack_start(@endecrypt_box,:expand => false, :fill => false, :padding => 2)
        @endecrypt_box.pack_start(@endecrypt_label,:expand => false, :fill => false, :padding => 2)
        @endecrypt_box.pack_start(@endecrypted_entry_text,:expand => true, :fill => true, :padding => 2)
 
        @hbox = Gtk::Box.new(Gtk::Orientation::HORIZONTAL, 2)
        @nvbox = Gtk::Box.new(Gtk::Orientation::VERTICAL, 2)
        
        @hbox.pack_start(@nvbox,:expand => false, :fill => false, :padding => 40)
        @vbox.pack_start(@hbox ,:expand => false, :fill => false, :padding => 2)

        @group = nil
        button = nil
        ["Ceasar", "Vigenere"].each do | name |
            button = Gtk::RadioButton.new(:group => @group, :label => name)
            @group = button.group

            @nvbox.pack_start(button, :expand => false, :fill => false, :padding => 1)
        end

        button.signal_connect "clicked" do
            on_toggle()
        end

        @key_label = Gtk::Label.new("Key")
        @key_entry = Gtk::Entry.new()

        @hbox.pack_start(@key_label,:expand => false, :fill => false, :padding => 2)
        @hbox.pack_start(@key_entry,:expand => false, :fill => false, :padding => 2)

        @ok_button = Gtk::Button.new(:label => "Apply")
        @hbox.pack_start(Gtk::Label.new("                 "),:expand => true, :fill => true, :padding => 2)
        @hbox.pack_end(@ok_button, :expand => true, :fill => true, :padding => 2)
        
        @ok_button.signal_connect "clicked" do 
            on_click()
        end

    end

    def on_toggle()
        @group.each do |element|
            @crypto_type = element.label if element.active?
        end
    end

    def on_click()
        encrypter = Cypher.new(@crypto_type, @key_entry.text)
=begin        
        if !(@message_entry_text.text.nil?)
            message = @message_entry_text.text 
            encrypter.encrypt(message)
            @endecrypted_entry_text.set_text(message)
        elsif
            enc = @endecrypted_entry_text.text()
            encrypter.decrypt(enc)
            @message_entry_text.set_text(enc)
        end
=end
        message = @message_entry_text.text
        if (message == "")
            enc = @endecrypted_entry_text.text()
            encrypter.decrypt(enc)
            @message_entry_text.set_text(enc)
        else
            message = @message_entry_text.text 
            encrypter.encrypt(message)
            @endecrypted_entry_text.set_text(message)

        end
    end

end 

def main()
    gui = FrontEnd.new()
    gui.show_all()
    Gtk.main()
end 

main()
