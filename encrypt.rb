require './lib/classes/key'
require './lib/classes/offset'
require './lib/classes/shift'
require './lib/classes/enigma'

puts "You are creating a cipher using the enigma machine. Please enter something to cipher:"
user_message = gets.chomp.downcase
message1 = File.open(ARGV[0], "w")
writer.write(user_message)
writer.close

# File.write('message.txt', user_message)

message = File.open(ARGV[0], "r")
incoming_message = message.read
message.close
capitalized_message = incoming_message.downcase
writer = File.open(ARGV[1], "w")
writer.write(capitalized_message)
writer.close
puts "Created '#{ARGV[1]}' with the key .... and date ..."
