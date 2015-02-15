
class CellGroup
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

  def candidates_outside_of exclude_cell
    candidates = []
    @cells.each do |c|
      candidates += c.candidates unless c == exclude_cell
    end
    return candidates.uniq.sort
  end

end