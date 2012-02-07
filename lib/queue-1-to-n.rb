require 'bunny'

b = Bunny.new({:logging => false}, {:spec => "09"})
b.start

# producer
e = b.exchange("1-to-n", :type => "fanout")

# consumer1
q1 = b.queue("1-to-n-myqueue-1")
q1.bind e

# consumer2
q2 = b.queue("1-to-n-myqueue-2")
q2.bind e

# producer
e.publish("PAYLOAD")

# consumer 1
msg = q1.pop
puts "CONSUMER1: This is the message: #{msg}"
puts "CONSUMER1: This is the payload: #{msg[:payload]}"

# consumer 2
msg = q2.pop
puts "CONSUMER2: This is the message: #{msg}"
puts "CONSUMER2: This is the payload: #{msg[:payload]}"

b.stop