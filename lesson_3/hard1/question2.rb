greetings = { a: 'hi' }
informal_greeting = greetings[:a]
informal_greeting << ' there'

puts informal_greeting  #  => "hi there"
puts greetings    # => {a: '"hi there"}. The "<<" will reference to the same object. 
                  # In this case informal_greeting is pointing to the greetings object. When << is used it changes the object being referenced which is greetings.
                  # By either cloning greetings or using "+ there" we could fix this.