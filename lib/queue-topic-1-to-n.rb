require 'bunny'

b = Bunny.new({:logging => false}, {:spec => "09"})
b.start

# producer
e = b.exchange("1-to-n-topic", :type => "topic")

# consumer1
q1 = b.queue("1-to-n-myqueue-topic-1")
q1.bind e, :key => 'one.#'

# consumer2
q2 = b.queue("1-to-n-myqueue-topic-2")
q2.bind e, :key => '*.two.*'

# producer
e.publish("PAYLOAD FOR THE FIRST ONE", :key => "one.five")
e.publish("PAYLOAD FOR THE SECOND ONE", :key => "five.two.three")
e.publish("PAYLOAD FOR BOTH", :key => "one.two.three")

# consumer 1
msg = q1.pop
puts "CONSUMER1: This is the message: #{msg}"
puts "CONSUMER1: This is the payload: #{msg[:payload]}"

# consumer 2
msg = q2.pop
puts "CONSUMER2: This is the message: #{msg}"
puts "CONSUMER2: This is the payload: #{msg[:payload]}"

# consumer 1
msg = q1.pop
puts "CONSUMER1: This is the message: #{msg}"
puts "CONSUMER1: This is the payload: #{msg[:payload]}"

# consumer 2
msg = q2.pop
puts "CONSUMER2: This is the message: #{msg}"
puts "CONSUMER2: This is the payload: #{msg[:payload]}"

b.stop