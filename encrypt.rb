message = File.open(ARGV[0], "r")
incoming_message = message.read
message.close
capitalized_message = incoming_message.downcase
writer = File.open(ARGV[1], "w")
writer.write(capitalized_message)
writer.close
puts "Created '#{ARGV[1]}' with the key .... and date ..."
