
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

end