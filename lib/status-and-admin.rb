require 'bunny'

b = Bunny.new({:logging => false}, {:spec => "09"})
b.start

# producer
q = b.queue("myqueue")
e = b.exchange("")
e.publish("PAYLOAD", :key => 'myqueue')

# print status before
p "STATUS BEFORE RECEIVING:"
p q.status

#q.purge - delete everything from the queue

# consumer
msg = q.pop
puts "This is the message: #{msg}"
puts "This is the payload: #{msg[:payload]}"

# print status after
p "STATUS AFTER RECEIVING:"
p q.status

b.stop