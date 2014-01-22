require "socket"

server = "irc.bitmakerlabs.com"
port = "6667"
nick = "HelloBot2"
channel = "#cohort5"
greeting_prefix = "privmsg #bitmaker :"
#greetings = ["hello", "hi", "hola", "yo", "wazup", "guten tag", "howdy", "salutations", "who the hell are you?"]
greetings=["ziggy"]

irc_server = TCPSocket.open(server, port)

irc_server.puts "USER bhellobot2 0 * BHelloBot2"
irc_server.puts "NICK #{nick}"
irc_server.puts "JOIN #{channel}"
irc_server.puts "PRIVMSG #{channel} :Hello from IRC Bot"

# Hello, Bot!
until irc_server.eof? do
  msg = irc_server.gets.downcase
  puts msg

  was_greeted = false
  greetings.each do |g|
    was_greeted = true if msg.include?(g)
    puts "********************  greeted: #{was_greeted}"
  end

  if msg.include?(greeting_prefix) and was_greeted
          response = "w00t! Someone talked to us!!!! Hello!!!"
          irc_server.puts "PRIVMSG #{channel} :#{response}"
  end
end