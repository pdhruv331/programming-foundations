words = "this is a string"
  words = words.chars.each { |chr| chr.capitalize!}.join
p words