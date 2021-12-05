
pos = 0
depth = 0

File.each_line("input.txt") do |line|
  dir, dist = line.split(" ", 2)
  dist = dist.to_i

  case dir 
  when "forward"
    pos += dist
  when "down"
    depth += dist
  when "up"
    depth -= dist
  else
    raise "unknown command: #{dir}"
  end
end

puts pos * depth
