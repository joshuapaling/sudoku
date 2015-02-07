require './cell.rb'

EG1 = {
  1 => [0, 2, 0,    9, 7, 3,    0, 5, 0],
  2 => [0, 0, 0,    2, 1, 8,    0, 0, 0],
  3 => [0, 0, 3,    6, 4, 0,    0, 0, 0],

  4 => [0, 0, 2,    8, 3, 9,    4, 0, 0],
  5 => [0, 4, 6,    5, 2, 7,    8, 0, 1],
  6 => [0, 5, 0,    0, 6, 4,    2, 0, 7],

  7 => [0, 0, 0,    0, 0, 0,    0, 0, 0],
  8 => [7, 9, 1,    4, 0, 0,    0, 0, 0],
  9 => [0, 0, 5,    0, 8, 6,    0, 0, 0],
}


class Sudoku
  def initialize
    @cells = []
    EG1.each do | row_num, row |
      row.each_with_index do | val, col_num |
        puts "row_num: #{row_num}, col_num: #{col_num}, val: #{val}"
        @cells << Cell.new(col_num + 1, row_num, val, self)
      end
    end
  end

  def solve!
    return if solved?
    @cells.each do |c|
      c.solve!
    end

  end

  def solved?
    solved = true
    @cells.each do |c|
      solved = false if !c.solved?
    end
    return solved
  end

  def pretty_print
    @cells.each do |c|
      print " #{c.to_s} "
      if c.last_in_row
        puts '' #we just want a new line
      end
    end
    return # just to stop pry printing the @cells array
  end

  def row_vals row_num
    vals = []
    @cells.each do |c|
      if c.x == row_num
        vals << c.val
      end
    end
    return vals
  end

  def col_vals col_num
    vals = []
    @cells.each do |c|
      if c.y == col_num
        vals << c.val
      end
    end
    return vals
  end

  def square_vals square_x, square_y
    vals = []
    @cells.each do |c|
      x_candidates = thirds square_x
      y_candidates = thirds square_y
      if x_candidates.include?(c.x) && y_candidates.include?(c.y)
        vals << c.val
      end
    end
    return vals
  end

  def thirds num
    case num
    when 1
      range = 1..3
    when 2
      range = 4..6
    when 3
      range = 7..9
    end
    return range
  end

end


