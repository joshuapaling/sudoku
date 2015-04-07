module Sudoku
  module Techniques

    # Like naked pairs, but for groups of 3 and 4.
    class NakedSubset
      def self.call(cell)
        self.new(cell).call
      end

      def initialize(cell)
        @cell = cell
        @sizes = (3..4)
      end

      def call
        @sizes.each do |i|
          @cell.each_scope do |scope|
            naked_subset_in_scope(i, scope)
          end
        end
      end

      def naked_subset_in_scope(size, scope)
        return unless @cell.candidates.count == size
        naked_subset = [@cell]
        scope.unsolved_cells_other_than(@cell) do |c|
          if is_subset_of(c.candidates, @cell.candidates)
            naked_subset << c
          end
          if naked_subset.count == size
            scope.eliminated_from_all_excluding(@cell.candidates, naked_subset)
          end
        end
      end

    private
      def is_subset_of(subset, superset)
        (subset - superset).empty?
      end

    end # class HiddenSingle
  end # module Techniques
end # module Sudoku
