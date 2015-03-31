module Sudoku
  class Cell
    # Never allow @candidates to be writable outside this class.
    # It should only be changed via 'eliminate_candidates' method
    attr_reader :x, :y, :candidates
    attr_accessor :val

    def initialize x, y, val, game
      @x = x
      @y = y
      @game = game
      @val = val
      @candidates = @val ? [] : (1..9).to_a
      @has_twin = false
    end

    def each_scope
      [row, col, box].each do |scope|
        yield(scope)
      end
    end

    def eliminate_candidates(arr)
      return if solved?
      if (@candidates - arr).empty?
        raise 'We should NOT be eliminating all candidates! Must always be one left. Cell: ' + coords_str + ' eliminating ' + arr.to_s + ' from ' + @candidates.to_s
      end
      @candidates = @candidates - arr
      solve_if_lone_candidate!
    end

    def eliminate_candidate(i)
      eliminate_candidates([i])
    end

    def solve_if_lone_candidate!
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

    def box
      @box ||= @game.box(box_x, box_y)
    end

    def box_x
      (@x / 3.0).ceil
    end

    def box_y
      (@y / 3.0).ceil
    end

    def candidate_count
      @candidates.count
    end

    def coords_str
      [@x, @y].to_s
    end

  end
end