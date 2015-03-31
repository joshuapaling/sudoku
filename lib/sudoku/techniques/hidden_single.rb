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
          other_candidates = scope.candidates_outside_of(@cell)
          remaining_candidates = @cell.candidates - other_candidates
          if remaining_candidates.count == 1
            puts  @cell.coords_str + ': Hidden Single (' + remaining_candidates[0].to_s + '): ' + scope.candidates_outside_of(@cell).to_s + ' from ' + @cell.candidates.to_s
            @cell.eliminate_candidates(other_candidates)
          end
        end
      end

    end # class HiddenSingle
  end # module Techniques
end # module Sudoku
