last = nil
num_increased = 0

File.read_lines("input.txt").each do |line|
  num = line.to_i

  num_increased += 1 if last && num > last

  last = num
end

puts num_increased
