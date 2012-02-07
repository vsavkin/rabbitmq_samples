require 'bunny'

b = Bunny.new({:logging => false}, {:spec => "09"})
b.start

# producer
# marking queue as durable tells rabbit to save all persistent messages sent do the queue
q = b.queue("durable_myqueue", :durable => true)

# marking exchange as durable, tells rabbit to store the exchange between restarts
e = b.exchange("", :durable => true)
e.publish("PAYLOAD", :key => 'durable_myqueue', :persistent => true)


# consumer
msg = q.pop
puts "This is the message: #{msg}"
puts "This is the payload: #{msg[:payload]}"

b.stop