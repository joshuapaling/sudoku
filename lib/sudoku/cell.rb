module Sudoku
  class Cell
    attr_reader :x, :y
    attr_accessor :candidates, :val

    def initialize x, y, val, game
      @x = x
      @y = y
      @game = game
      @val = val
      @candidates = @val ? [] : (1..9).to_a
      @has_twin = false
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
        cell_group.eliminate_twin_candidates(self)
        cell_group.eliminate_restricted_candidates_from_overlapping_cell_groups(self)
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

    def eliminate_candidate(i)
      @candidates = @candidates - [i]
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
      return (@val.to_s) ? @val : '-'
    end

    def row
      @row ||= @game.row(@x)
    end

    def col
      @col ||= @game.col(@y)
    end

    def square
      @square ||= @game.square(square_x, square_y)
    end

    def square_x
      (@x / 3.0).ceil
    end

    def square_y
      (@y / 3.0).ceil
    end

  end
end