require './lib/classes/key'
require './lib/classes/offset'
require './lib/classes/shift'
require './lib/classes/enigma'
require 'pry'

message = File.open(ARGV[0], "r")
incoming_message = message.read.chomp.downcase
message.close

enigma = Enigma.new
enigma.decrypt(incoming_message, "03262", "290719")
enigma.decrypted_text

decrypted_message = enigma.decrypted_text
writer = File.open(ARGV[1], "w")
writer.write(decrypted_message)
writer.close
puts "Created '#{ARGV[1]}' with the key #{enigma.key_object.five_digit_key} and date #{enigma.offset_object.chosen_date}"
