require './lib/classes/key'
require './lib/classes/offset'
require './lib/classes/shift'
require './lib/classes/enigma'
require 'date'
require 'pry'

current_date = DateTime.now
current_date_string = current_date.strftime("%d%m%y").to_s

message = File.open(ARGV[0], "r")
incoming_message = message.read.chomp.downcase
message.close

ARGV[3] = current_date_string if ARGV[3].nil? == true

enigma = Enigma.new
enigma.decrypt(incoming_message, ARGV[2], ARGV[3])
enigma.decrypted_text

decrypted_message = enigma.decrypted_text
writer = File.open(ARGV[1], "w")
writer.write(decrypted_message)
writer.close
puts "Created '#{ARGV[1]}' with the key #{enigma.key_object.five_digit_key} and date #{enigma.offset_object.chosen_date}"
