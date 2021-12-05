
def most_common_at(data, idx)
  row = data.transpose[idx]
  sum = row.sum(0)
  size = row.size

  puts({sum: sum, size: size, most_common: ((sum >= size/2) ? 1 : 0).to_i8})

  ((sum >= size/2) ? 1 : 0).to_i8
end

def least_common_at(data, idx)
  row = data.transpose[idx]
  sum = row.sum(0)
  size = row.size
  puts({sum: sum, size: size, least_common: ((sum >= size/2) ? 0 : 1).to_i8})

  ((sum >= size/2) ? 0 : 1).to_i8
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

def pp(bits)
  "#{batos(bits)} (#{batoi(bits)})"
end

data = [] of Array(Int8)

File.each_line("input.txt") do |line|
  row = line.each_char.map { |c| c == '1' ? 1.to_i8 : 0.to_i8 }.to_a
  data << row
end

def filter_candidates_at_pos(candidates, pos = 0, &criteria : (Array(Array(Int8)), Int32) -> Int8)
  val = criteria.call(candidates, pos)
  candidates = candidates.select { |candidate| candidate[pos] == val }

  return candidates.first if candidates.size == 1

  filter_candidates_at_pos(candidates.dup, pos + 1, &criteria)
end

oxygen = filter_candidates_at_pos(data.dup) { |candidates, pos|
  most_common_at(candidates, pos)
}

co2 = filter_candidates_at_pos(data.dup) { |candidates, pos|
  least_common_at(candidates, pos)
}


puts({oxygen: pp(oxygen), co2: pp(co2), product: batoi(oxygen) * batoi(co2)})
