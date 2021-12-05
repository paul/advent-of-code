lines = File.read_lines("input.txt") 
last = nil
num_increased = 0
lines.each do |line|
  num = line.to_i

  if last && num > last
    num_increased += 1
  end

  last = num
end

puts num_increased
