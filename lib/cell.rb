class Cell
  attr_reader :x, :y
  attr_accessor :candidates, :val

  def initialize x, y, val, board
    @x = x
    @y = y
    @board = board
    if val == 0
      val = nil # having val as 0 is just cos it's 2 less chars than nil. Stupid shortcut!
    end
    @val = val
    @candidates = @val ? [] : (1..9).to_a
  end

  def each_cell_group
    [row, col, square].each do |cell_group|
      yield(cell_group)
    end
  end

  def solve!
    return if solved?
    each_cell_group do |cell_group|
      eliminate_candidates_by_values(cell_group)
      check_for_exclusive_candidate(cell_group)
    end
    check_if_solved
  end

  # This is the means to solve easy puzzles
  def eliminate_candidates_by_values(cell_group)
    @candidates = @candidates - cell_group.vals
  end

  # This is used to solve medium puzzles
  def check_for_exclusive_candidate(cell_group)
    remaining_candidates = @candidates - cell_group.candidates_outside_of(self)
    if remaining_candidates.count == 1
      @candidates = remaining_candidates
    end
  end

  def check_if_solved
    if @candidates.count == 1
      @val = @candidates[0]
      @candidates = []
    end
  end

  def solved?
    return @val
  end

  def last_in_row
    return @x == 9
  end

  def to_s
    return (@val) ? @val : '-'
  end

  def row
    @row ||= @board.row(@x)
  end

  def col
    @col ||= @board.col(@y)
  end

  def square
    @square ||= @board.square(square_x, square_y)
  end

  def square_x
    (@x / 3.0).ceil
  end

  def square_y
    (@y / 3.0).ceil
  end

end