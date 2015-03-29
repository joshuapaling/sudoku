module Sudoku
  module Techniques

    # This technique will solve medium puzzles.
    # For a given cell, check if any of the candidates are
    # exclusive to that cell, within the cells row, col or box
    class HiddenSingle
      def self.call(cell)
        self.new(cell).call
      end

      def initialize(cell)
        @cell = cell
      end

      def call
        @cell.each_scope do |scope|
          remaining_candidates = @cell.candidates - scope.candidates_outside_of(@cell)
          if remaining_candidates.count == 1
            @cell.candidates = remaining_candidates
          end
        end
      end

    end # class HiddenSingle
  end # module Techniques
end # module Sudoku
