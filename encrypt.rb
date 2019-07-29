require './lib/classes/key'
require './lib/classes/offset'
require './lib/classes/shift'
require './lib/classes/enigma'
require 'pry'

todays_date = DateTime.now
current_date_string = todays_date.strftime("%d%m%y").to_s

message = File.open(ARGV[0], "r")
incoming_message = message.read.chomp.downcase
message.close

enigma = Enigma.new
enigma.encrypt(incoming_message, "1234", "121256")
enigma.encrypted_text
# binding.pry

capitalized_message = enigma.encrypted_text
writer = File.open(ARGV[1], "w")
writer.write(capitalized_message)
writer.close
puts "Created '#{ARGV[1]}' with the key #{enigma.key_object.five_digit_key} and date #{enigma.offset_object.chosen_date}"
