require "socket"

server = "irc.bitmakerlabs.com"
port = "6667"
nick = "HelloBot2"
channel = "#cohort5"
greeting_prefix = "privmsg #{channel} :"
greetings=["who's there?"]
greetings1=["dismay who?"]

irc_server = TCPSocket.open(server, port)

irc_server.puts "USER bhellobot2 0 * BHelloBot2"
irc_server.puts "NICK #{nick}"
irc_server.puts "JOIN #{channel}"
irc_server.puts "PRIVMSG #{channel} :Knock, Knock!"

# Hello, Bot!
until irc_server.eof? do
  msg = irc_server.gets.downcase
  puts msg

  stage_one = false
  greetings.each do |g|
    stage_one = true if msg.include?(g)
    puts "greeted: #{stage_one}"
  end

  stage_two = false
  greetings1.each do |g|
    stage_two = true if msg.include?(g)
    puts "greeted: #{stage_two}"
  end

  if msg.include?(greeting_prefix) && stage_one 
    response = "dismay"
    irc_server.puts "PRIVMSG #{channel} :#{response}"
  elsif msg.include?(greeting_prefix) && stage_two 
    response = "Dismay be a bad joke but I think it's funny!"
    irc_server.puts "PRIVMSG #{channel} :#{response}"      
  end
end
