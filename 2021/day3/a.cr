
data = [] of Array(Int8)

File.each_line("input.txt") do |line|
  row = line.each_char.map { |c| c == '1' ? 1.to_i8 : 0.to_i8 }.to_a
  data << row
end

freqs = [] of Int8

data.transpose.each do |el| # convert columns to rows
  sum = el.sum(0) # Start with i32, otherwise it defaults to i8 and overflows
  size = el.size
  common = (sum > size/2) ? 1 : 0
  puts({sum: sum, size: size, common: common })

  freqs << common.to_i8
end

def batos(bits)
  bits.join("")
end

def batoi(bits) 
  num = 0.to_i32
  bits.reverse.each_with_index do |bit, i|
    num += bit.to_i32 << i
  end
  num
end

inverse = freqs.map { |i| i > 0 ? 0 : 1}
puts({freqs: freqs, inverse: inverse})

gamma = batoi(freqs)
epsilon = batoi(inverse)

puts "Part 1"
puts({gamma: gamma, epsilon: epsilon, product: gamma * epsilon})

def filter(data, criteria)
  candidates = data.dup
  criteria.each_with_index do |v, i|
    candidates.reject! { |candidate| candidate[i] != v }

    puts "============"
    puts batos(criteria)
    puts "------------"
    puts candidates.map { |r| batos(r) }.join("\n")
    puts

    return candidates.first if candidates.size == 1
  end
  [] of Int8
end

oxygen = filter(data, freqs)
co2    = filter(data, inverse)

puts({oxygen: "#{oxygen} (#{batoi(oxygen)})", co2: "#{co2} (#{batoi(co2)})"})
puts batoi(oxygen) * batoi(co2)

