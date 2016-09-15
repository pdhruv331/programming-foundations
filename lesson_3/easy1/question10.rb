flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]
new_hash = {}
flintstones.each_with_index do |name, index|
  new_hash[name] = index
end