        def tricky_method(a_string_param, an_array_param)
  a_string_param += "rutabaga"
  an_array_param << "rutabaga"
end

my_string = "pumpkins"
my_array = ["pumpkins"]
tricky_method(my_string, my_array)

puts "My string looks like this now: #{my_string}"
puts "My array looks like this now: #{my_array}"

# This will display: My string looks like this now: pumpkins              
# This will display: My string looks like this now: ["pumpkins", "rutabaga"]
# The reason is that when rutabaga is pushed into the end of the array it mutates the array.
# Whereas adding rutabaga to the string does not. The "<<" method is destructive and it refers to the same object.
