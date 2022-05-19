hash = {}

index = 0

('a'..'z').each do |c|
    
    if ['a', 'e', 'i', 'o', 'u', 'y'].include? c
        hash[c] = index
    end

    index+=1
end

puts hash
