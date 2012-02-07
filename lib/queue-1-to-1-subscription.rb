require 'bunny'

b = Bunny.new({:logging => false}, {:spec => "09"})
b.start

# producer
q = b.queue("myqueue")

# default exchange, route by the key
e = b.exchange("")
e.publish("PAYLOAD", :key => 'myqueue')

q.subscribe do |msg|
  puts "This is the message: #{msg}"
  puts "This is the payload: #{msg[:payload]}"
end

b.stop