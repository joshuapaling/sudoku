module Sudoku
  class Cell
    # Never allow @candidates to be writable outside this class.
    # It should only be changed via 'eliminate_candidates' method
    attr_reader :x, :y, :candidates
    attr_accessor :val

    def initialize(x, y, val, game, solved_val = nil)
      @x = x
      @y = y
      @game = game
      @val = val
      @candidates = @val ? [] : (1..9).to_a
      @has_twin = false
      @solved_val = solved_val
    end

    def each_scope
      [row, col, box].each do |scope|
        yield(scope)
      end
    end

    def eliminate_candidates(arr)
      return if solved?
      if @solved_val && (arr).include?(@solved_val)
        # puts PrettyPrinter.new.color_print_game(@game)
        raise 'We should NOT be eliminating the solution value of ' + @solved_val.to_s + '! Cell: ' + coords_str + ' eliminating ' + arr.to_s + ' from ' + @candidates.to_s
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
      @row ||= @game.row(@y)
    end

    def col
      @col ||= @game.col(@x)
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
