module Sudoku
  class Game
    def initialize(state = [], solution = nil)
      @cells = []
      set_initial_state(state, solution)
    end

    def set_initial_state(state, solution)
      state.each_with_index do | row, row_num |
        row.each_with_index do | val, col_num |
          val = nil if val == 0 # having val as 0 is just cos it's 2 less chars than nil. Stupid shortcut!
          if solution
            solved_val = solution[row_num][col_num]
          end
          @cells << Cell.new(col_num + 1, row_num + 1, val, self, solved_val)
        end
      end
    end

    def techniques
      [
        Sudoku::Techniques::Elimination,
        Sudoku::Techniques::HiddenSingle,
        Sudoku::Techniques::NakedPair,
        Sudoku::Techniques::LockedCandidate,
      ]
    end

    def solve!
      until stuck? || solved? do
        @prev_candidate_count = candidate_count
        apply_all_techniques
      end
    end

    def apply_all_techniques
      unsolved_cells.each do |cell|
        techniques.each do |technique|
          technique.call(cell)
        end
      end
    end

    def candidate_count
      count = 0
      @cells.each do |c|
        count += c.candidate_count
      end
      return count
    end

    def stuck?
      @prev_candidate_count == candidate_count
    end

    def solved?
      solved = true
      @cells.each do |c|
        solved = false if !c.solved?
      end
      return solved # ToDo - need to check the solution to make sure there's no errors.
    end

    def unsolved_cells
      @cells.select { |c| !c.solved? }
    end

    def row(row_num)
      vals = []
      @cells.each do |c|
        if c.y == row_num
          vals << c
        end
      end
      return Scope.new(vals)
    end

    def col(col_num)
      vals = []
      @cells.each do |c|
        if c.x == col_num
          vals << c
        end
      end
      return Scope.new(vals)
    end

    def box(box_x, box_y)
      vals = []
      @cells.each do |c|
        x_candidates = thirds(box_x)
        y_candidates = thirds(box_y)
        if x_candidates.include?(c.x) && y_candidates.include?(c.y)
          vals << c
        end
      end
      return Scope.new(vals)
    end

    def cell_at(x, y)
      @cells.detect{|c| c.x == x && c.y == y}
    end

  private
    def thirds(num)
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
end
