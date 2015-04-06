module Sudoku
  module Techniques

    # This technique will solve easy puzzles.
    # For a given cell, eliminate the already solved cells
    # in that cell's box, row and column.
    class Elimination
      def self.call(cell)
        self.new(cell).call
      end

      def initialize(cell)
        @cell = cell
      end

      def call
        @cell.each_scope do |scope|
          eliminate_for_scope(scope)
        end
      end

      def eliminate_for_scope(scope)
        @cell.eliminate_candidates(scope.vals_outside_of(@cell))
      end

    end

  end
end
