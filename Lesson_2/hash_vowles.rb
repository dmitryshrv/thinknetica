hash = {}
index = 0

('a'..'z').each do |char|
  if ['a', 'e', 'i', 'o', 'u', 'y'].include? c
    hash[char] = index
  end
  index += 1
end

puts hash
