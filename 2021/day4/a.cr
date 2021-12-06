require "colorize"

class Board
  def initialize
    @rows = [] of Array(Int32)
    @matches = [] of Int32
  end

  def add_row(row)
    @rows << row
  end

  def add(number)
    @matches.push(number) if @rows.flatten.includes?(number)
  end

  def empty?
    @rows.empty?
  end

  def winner?
    !@matches.empty? &&
      @rows.any? { |row| row.all? { |cell| @matches.includes?(cell) } } ||
      @rows.transpose.any? { |col| col.all? { |cell| @matches.includes?(cell) } } 
  end

  def score
    # Sum of all unmarked numbers
    @rows.flatten.select { |cell| !@matches.includes?(cell) }.sum *
      # Mult number that was just called
      @matches.last

  end

  def pp
    out = String::Builder.new
    @rows.each do |row|
      row.each do |cell|
        txt =  "%3i" % cell
        txt = txt.colorize.red if @matches.includes?(cell)
        txt = txt.colorize.bold if !@matches.empty? && @matches[-1] == cell
        out << txt
      end
      out << "\n"
    end
    out << "\n"
    out.to_s
  end

end

numbers = [] of Int32
boards = [] of Board
board = Board.new

File.each_line("input.txt") do |line|
  if numbers.empty?
    numbers = line.split(",").map { |n| n.to_i }
    next
  end

  if line.blank?
    boards << board unless board.empty?
    board = Board.new
    next
  end

  row = line.split(" ", remove_empty: true).map { |n| n.to_i }
  board.add_row(row)
end

# Part 1
numbers.each_with_index do |number, idx|
  puts "============="
  puts "Round: #{idx + 1}"
  puts number
  boards.each do |board|
    board.add(number)
  end

  winner = boards.find { |board| board.winner? }
  if winner
    puts "============="
    puts "Winner!"
    puts winner.pp
    puts winner.score
    break
  end
end

# Part 2
numbers.each_with_index do |number, idx|
  puts "============="
  puts "Round: #{idx + 1}"
  puts number
  boards.each do |board|
    board.add(number)
  end

  # Keep playing until that board wins
  if boards.size == 1
    loser = boards.last
    puts "============="
    puts "Loser!"
    puts loser.pp
    puts loser.score
    break if loser.winner?
  end

  boards.reject! { |board| board.winner? }
end
