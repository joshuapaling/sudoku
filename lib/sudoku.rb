require_relative 'cell'
require_relative 'cell_group'
require_relative 'examples'


class Sudoku
  def initialize state = []
    @cells = []
    set_initial_state(state)
  end

  def set_initial_state state
    state.each_with_index do | row, row_num |
      row.each_with_index do | val, col_num |
        @cells << Cell.new(col_num + 1, row_num + 1, val, self)
      end
    end
  end

  def solve!
    150.times do # need to implement a better way to decide when to stop. Probably just when nothing changes from the previous round.
      return if solved?
      @cells.each do |c|
        c.solve!
      end
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

  def row row_num
    vals = []
    @cells.each do |c|
      if c.x == row_num
        vals << c
      end
    end
    return CellGroup.new(vals)
  end

  def col col_num
    vals = []
    @cells.each do |c|
      if c.y == col_num
        vals << c
      end
    end
    return CellGroup.new(vals)
  end

  def square square_x, square_y
    vals = []
    @cells.each do |c|
      x_candidates = thirds square_x
      y_candidates = thirds square_y
      if x_candidates.include?(c.x) && y_candidates.include?(c.y)
        vals << c
      end
    end
    return CellGroup.new(vals)
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

  def cell_at x, y
    @cells.detect{|c| c.x == x && c.y == y}
  end
end


