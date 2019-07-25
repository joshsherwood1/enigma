require './lib/classes/key'
require './lib/classes/offset'
require './lib/classes/shift'
require './lib/classes/enigma'
require 'pry'

message = File.open(ARGV[0], "r")
incoming_message = message.read.chomp.downcase
message.close

enigma = Enigma.new
enigma.encrypt(incoming_message)
enigma.encrypted_text

capitalized_message = enigma.encrypted_text
writer = File.open(ARGV[1], "w")
writer.write(capitalized_message)
writer.close
puts "Created '#{ARGV[1]}' with the key #{enigma.key_object.five_digit_key} and date #{enigma.offset_object.chosen_date}"
