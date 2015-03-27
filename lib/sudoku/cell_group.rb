module Sudoku
  class CellGroup
    attr_accessor :cells

    def initialize cells
      @cells = cells
    end

    def vals
      vals = []
      @cells.each do |c|
        vals << c.val
      end
      return vals
    end

    def candidates_outside_of cell
      candidates = []
      @cells.each do |c|
        candidates += c.candidates unless c == cell
      end
      return candidates.uniq.sort
    end

    # This is used to solve difficult puzzles.
    # Look for a pair of cells in the same row/col/square that have
    # only two candidates, which are exactly the same. Then those
    # candidates can be eliminated from other cells.
    def eliminate_twin_candidates cell
      return unless cell.candidates.count == 2
      found_twin = false
      @cells.each do |c|
        if c.candidates == cell.candidates && c != cell
          found_twin = true
        end
      end

      # ELIMINATE THESE CANDIDATES FROM ALL OTHER CELLS IN THIS GROUP!
      if found_twin
        @cells.each do |c|
          if c.candidates != cell.candidates
            c.candidates = c.candidates - cell.candidates
          end
        end
      end
    end


  # PULL ALL THIS LOGIC OUT INTO A ExclusiveCellWithinCellGroupOverlapEliminator class or OverlappingCandidateEliminator class
    # If a particular number must exist in eg. Column A, within the space
    #  that overlaps with Square B, then that number can be eliminated
    #  as a candidate from all cells in Square B that do not overlap with Column A.
    #
    # Note this is really only relevant for squares and rows,
    # or squares and columns. It isn't relevant for rows and columns
    # because they can only overlay by one square.
    #
    # For each candidate in a cell group:
    # 1. Find the squares that that candidate can exist in
    # 2. See if those cells exclusively overlaps with the cells of another cell group
    # To overlap:
    # - either the x or the y must be the same
    # - for the other property, the square_x or square_y
    # 3. If so, delete that candidate from all other cells in that other cell group
    def eliminate_restricted_candidates_from_overlapping_cell_groups cell
      cell.candidates.each do |i|
        find_cells_with_candidate i, cell
      end
    end

    def find_cells_with_candidate i, cell
      cells_with_candidate = @cells.select do |c|
        c.candidates.include? i
      end

      # Now check if all the cells
      # have the same col and are in same square_y,
      # or have the same row and are in the same square_x

      if cells_with_candidate.detect { |c| c.x != cell.x || c.square_y != cell.square_y }
        # nope, not a match.
      else
        # There's unneeded call here. In each case, only one of the following two will actually
        # be needed, depending on wether this CellGroup itself (ie, `self`) is representing a row
        # or a square. If it's a row, we only need to act on the square, and vica versa.
        cell.square.eliminated_from_all_excluding(i, cells_with_candidate)
        cell.row.eliminated_from_all_excluding(i, cells_with_candidate)
      end

      if cells_with_candidate.detect { |c| c.y != cell.y || c.square_x != cell.square_x }
        # nope, not a match.
      else
        # There's unneeded call here. In each case, only one of the following two will actually
        # be needed, depending on wether this CellGroup itself (ie, `self`) is representing a row
        # or a square. If it's a col, we only need to act on the square, and vica versa.
        cell.square.eliminated_from_all_excluding(i, cells_with_candidate)
        cell.col.eliminated_from_all_excluding(i, cells_with_candidate)
      end

    end

    def eliminated_from_all_excluding(i, cells_to_exclude)
      remaining_cells = @cells.select {|c| !cells_to_exclude.include?(c) }
      remaining_cells.each {|c| c.eliminate_candidate(i) }
    end

  end
end