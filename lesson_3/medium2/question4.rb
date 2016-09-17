sentence = "Humpty Dumpty sat on a wall."
words = sentence.split(/\W/)
words.reverse!
reverse = words.join(" ") + "."
p reverse

