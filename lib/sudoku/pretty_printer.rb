module Sudoku
  class PrettyPrinter

    def print_row(r)
      cell_strs = r.cells.map do |cell|
        print_cell(cell).split("\n")
      end

      buffer = ''
      cell_strs[0].count.times do |i|
        cell_strs.each do |cell_str|
          # take all the first lines and append them,
          buffer += cell_str[i]
        end
        buffer += "\n"
      end
      return buffer
    end
    # Intended result (note spaces before first numbers,
    # and eliminated candidates are -):
    # --------
    #  1 2 3 |
    #  4 5 - |
    #  7 - 9 |
    #
    #  Or, for solves squares:
    #
    #  --------
    #  ` ` ` |
    #  ` 3 ` |
    #  ` ` ` |
    def print_cell(c)
      result = "--------\n"
      if c.solved?
        rows = <<EOT
 ` ` ` |
 ` #{c.val} ` |
 ` ` ` |
EOT
        result += rows # don't += on the same line as above, it screws up my syntax highlighting
        return result
      else
        result += print_unsolved_cell(c)
      end
      return result
    end

    def print_unsolved_cell(c)
      result = ''
      [(1..3), (4..6), (7..9)].each do |range|
        result += print_cell_candidate_row(c, range)
      end
      result
    end

    def print_cell_candidate_row(c, range)
      result = ''
      range.each do |i|
        if c.candidates.include?(i)
          result += ' ' + i.to_s
        else
          result += ' -'
        end
      end
      result += " |\n"
    end

  end # class PrettyPrinter
end # module Sudoku