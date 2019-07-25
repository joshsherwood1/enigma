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

@key = Key.new("")
@key.determine_the_key_to_use
@key.five_digit_key

@offset = Offset.new("")
@offset.determine_the_offset_to_use
@offset.four_digit_offset

@shift_1 = Shift.new(@key, @offset)
@shift_1.assign_letters_to_key_digits
@shift_1.assign_letters_to_offset_digits
@shift_1.make_shift_from_key_and_offset

@enigma = Enigma.new(@shift_1.make_shift_from_key_and_offset)
@enigma.encrypt(incoming_message, @key.five_digit_key, current_date_string)
# @enigma.create_rotated_character_set_a
@enigma.encrypted_text
# binding.pry

#
# puts "You are creating a cipher using the enigma machine. Please enter a key for the cipher:"
# user_key = gets.chomp

capitalized_message = @enigma.encrypted_text
writer = File.open(ARGV[1], "w")
writer.write(capitalized_message)
writer.close
puts "Created '#{ARGV[1]}' with the key #{@key.five_digit_key} and date #{current_date_string}"
