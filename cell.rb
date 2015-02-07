class Cell
  attr_reader :x, :y, :val
  def initialize x, y, val, board
    @x = x
    @y = y
    @board = board
    if val == 0
      val = nil # having val as 0 is just cos it's 2 less chars than nil. Stupid shortcut!
    end
    @val = val
    @candidates = (1..9).to_a
  end

  def solve!
    return if solved?
    @candidates = @candidates - row_vals - col_vals - square_vals
    if @candidates.count == 1
      @val = @candidates[0]
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

  def row_vals
    @board.row_vals @x
  end

  def col_vals
    @board.col_vals @y
  end

  def square_vals
    @board.square_vals(square_x, square_y)
  end

  def square_x
    (@x / 3.0).ceil
  end

  def square_y
    (@y / 3.0).ceil
  end

end