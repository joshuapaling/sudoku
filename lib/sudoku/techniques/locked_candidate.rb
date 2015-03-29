module Sudoku
  module Techniques

    # If a particular number must exist in eg. Column A, within the space
    #  that overlaps with Square B, then that number can be eliminated
    #  as a candidate from all cells in Square B that do not overlap with Column A.
    #  Likewise for Rows
    #
    # For each candidate in a cell scope:
    # 1. Find the cells from that scope that the candidate can exist in
    # 2. See if those cells exclusively overlaps with the cells of another cell scope
    # To overlap:
    # - either the x or the y must be the same
    # - for the other property, the box_x or box_y
    # 3. If so, delete that candidate from all other cells in that other cell scope
    class LockedCandidate
      def self.call(cell)
        self.new(cell).call
      end

      def initialize(cell)
        @cell = cell
      end

      def call
        @cell.each_scope do |scope|
          @scope = scope
          @cell.candidates.each { |i| find_for_candidate(i) }
        end
      end

      def find_for_candidate(i)
        cells = @scope.cells_with_candidate(i)
        line = common_line(cells)

        if line
          line.eliminated_from_all_excluding(i, cells)
          @cell.box.eliminated_from_all_excluding(i, cells)
        end
      end

      def common_line(cells)
        common_line = nil

        # Are all cells in the same row?
        if cells.detect { |c| c.x != @cell.x || c.box_y != @cell.box_y }
          # found a cell not in the same row
        else
          common_line = @cell.row
        end

        # Are all cells in the same col?
        if cells.detect { |c| c.y != @cell.y || c.box_x != @cell.box_x }
          # found a cell not in the same col
        else
          common_line = @cell.col
        end

        return common_line
      end

    end
  end
end
