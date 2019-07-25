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
enigma.encrypt(incoming_message)
enigma.encrypted_text
# binding.pry

capitalized_message = enigma.encrypted_text
writer = File.open(ARGV[1], "w")
writer.write(capitalized_message)
writer.close
puts "Created '#{ARGV[1]}' with the key ... and date ..."
# time1 = Time.new
# puts "Current Time : " + time1.inspect

# message1 = File.open(ARGV[0], "w")
# writer.write(message1)
# writer.close

# File.write('message.txt', user_message)

# message = File.open(ARGV[0], "r")
# incoming_message = message.read
# message.close
# capitalized_message = incoming_message.downcase
# writer = File.open(ARGV[1], "w")
# writer.write(capitalized_message)
# writer.close
# puts "Created '#{ARGV[1]}' with the key .... and date ..."
