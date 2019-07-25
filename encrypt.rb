require './lib/classes/key'
require './lib/classes/offset'
require './lib/classes/shift'
require './lib/classes/enigma'

puts "You are creating a cipher using the enigma machine. Please enter something to cipher:"
message = File.open(ARGV[0], "r")
incoming_message = message.read
message.close

capitalized_message = incoming_message.upcase
writer = File.open(ARGV[1], "w")
writer.write(capitalized_message)
writer.close
puts "Created '#{ARGV[1]}' with key .... and date ..."
time1 = Time.new
puts "Current Time : " + time1.inspect

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
puts "Created '#{ARGV[1]}' with the key .... and date ..."
