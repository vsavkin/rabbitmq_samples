require 'bunny'

b = Bunny.new({:logging => false}, {:spec => "09"})
b.start

# producer
# we are using the direct exchange here as fanout ignore the routing key
e = b.exchange("1-to-n-with-routing-keys-direct", :type => "direct")

# consumer1
q1 = b.queue("1-to-n-myqueue-1-with-routing-key")
q1.bind e, :key => "KEY1"

# consumer2
q2 = b.queue("1-to-n-myqueue-2-with-routing-key")
q2.bind e, :key => "KEY2"

# producer
e.publish("PAYLOAD1", :key => "KEY1")
e.publish("PAYLOAD2", :key => "KEY2")

# consumer 1
msg = q1.pop
puts "CONSUMER1: This is the message: #{msg}"
puts "CONSUMER1: This is the payload: #{msg[:payload]}"

# consumer 2
msg = q2.pop
puts "CONSUMER2: This is the message: #{msg}"
puts "CONSUMER2: This is the payload: #{msg[:payload]}"

b.stop