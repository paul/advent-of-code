
class Window
  def initialize(max = 3)
    @max = max
    @elements = [] of Int32
  end

  def push(el : Int32)
    @elements.push(el)
    @elements.shift if @elements.size > @max
  end

  def sum
    return nil unless @elements.size == @max
    @elements.sum
  end
end

window = Window.new(3)
last_sum = nil
num_increased = 0

File.read_lines("input.txt").each do |line|
  window.push(line.to_i)
  sum = window.sum

  num_increased += 1 if last_sum && sum && sum > last_sum

  last_sum = window.sum
end

puts num_increased
