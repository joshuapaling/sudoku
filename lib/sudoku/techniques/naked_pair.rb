module Sudoku
  module Techniques

    # This is used to solve difficult puzzles.
    # Look for a pair of cells in the same row/col/box that have
    # only two candidates, which are exactly the same. Then those
    # candidates can be eliminated from other cells.
    class NakedPair
      def self.call(cell)
        self.new(cell).call
      end

      def initialize(cell)
        @cell = cell
      end

      def call
        return unless @cell.candidates.count == 2
        @cell.each_scope do |scope|
          find_twins_in_scope(scope)
        end
      end

      def find_twins_in_scope(scope)
        scope.cells_other_than(@cell) do |c|
          if c.candidates == @cell.candidates
            twin = c
            scope.eliminated_from_all_excluding(@cell.candidates, [@cell, twin])
          end
        end
      end

    end # class HiddenSingle
  end # module Techniques
end # module Sudoku
