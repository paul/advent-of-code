
pos = 0
depth = 0
aim = 0

File.each_line("input.txt") do |line|
  dir, dist = line.split(" ", 2)
  dist = dist.to_i

  case dir 
  when "down"
    aim += dist
  when "up"
    aim -= dist
  when "forward"
    pos += dist
    depth += dist * aim
    puts "pos: #{pos}, aim: #{aim}, depth: #{depth}"
  else
    raise "unknown command: #{dir}"
  end
end

puts pos * depth
