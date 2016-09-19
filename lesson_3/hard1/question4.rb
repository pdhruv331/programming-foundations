
def uuid
  hexadecimal_chars = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
  hexadecimal_chars.insert(10, 'a', 'b', 'c', 'd', 'e', 'f')
  arr = []
  32.times do
    arr = arr.push(hexadecimal_chars.sample)
  end
  arr = arr.insert(8, '-').insert(13, '-').insert(18, '-').insert(23, '-').join
  arr
end

uuid
