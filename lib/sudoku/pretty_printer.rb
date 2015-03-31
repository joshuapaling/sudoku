module Sudoku
  class PrettyPrinter

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