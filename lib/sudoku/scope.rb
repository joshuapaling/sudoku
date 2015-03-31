module Sudoku
  class Scope
    attr_accessor :cells

    def initialize cells
      @cells = cells
    end

    def vals_outside_of(cell)
      vals = []
      @cells.each do |c|
        vals << c.val unless c == cell
      end
      return vals
    end

    def candidates_outside_of(cell)
      candidates = []
      @cells.each do |c|
        candidates += c.candidates unless c == cell
      end
      return candidates.uniq.sort
    end

    def cells_other_than(cell)
      other_cells = (@cells - [cell])
      if block_given?
        other_cells.each { |c| yield(c) }
      end
      return other_cells
    end

    def eliminated_from_all_excluding(arr, cells_to_exclude)
      if arr.is_a?(Fixnum)
        arr = [arr]
      end
      remaining_cells = @cells.select { |c| !cells_to_exclude.include?(c) }
      remaining_cells.each {|c| c.eliminate_candidates(arr) }
    end

    def cells_with_candidate(i)
      @cells.select { |c| c.candidates.include?(i) }
    end

  end
end