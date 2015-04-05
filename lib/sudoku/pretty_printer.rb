module Sudoku
  class PrettyPrinter

    def print_game(g)
      row_sep = "|%|%%%%%%%|%%%%%%%|%%%%%%%|%|%%%%%%%|%%%%%%%|%%%%%%%|%|%%%%%%%|%%%%%%%|%%%%%%%|%|\n"
      buffer = row_sep
      (1..9).each do |i|
        buffer += print_row(g.row(i))
        buffer += row_sep if (i % 3 == 0)
      end
      return buffer
    end

    def color_print_game(g)
      buffer = print_game(g)
      buffer.gsub!(/%/, '%'.yellow.on_yellow)
      buffer.gsub!(/\|/, '|'.yellow.on_yellow)
      buffer.gsub!(/-------/, '-------'.yellow.on_yellow)
      buffer.gsub!(/ ` ` ` /, ' ` ` ` '.black.on_green)
      buffer.gsub!(/ ` (\d) ` /, ' ` \1 ` '.black.on_green)
    end

    def print_row(r)
      cell_strs = r.cells.map do |cell|
        print_cell(cell).split("\n")
      end

      buffer = ''
      cell_strs[0].count.times do |i|
        buffer += '|%|'
        cell_strs.each_with_index do |cell_str, j|
          buffer += cell_str[i]
          buffer += '%|' if ((j+1) % 3 == 0)
        end
        buffer += "\n"
      end
      return buffer
    end
    # Intended result (note spaces before first numbers,
    # and eliminated candidates are -):
    # -------|
    #  1 2 3 |
    #  4 5 - |
    #  7 - 9 |
    #
    #  Or, for solves squares:
    #
    #  ------|
    #  ` ` ` |
    #  ` 3 ` |
    #  ` ` ` |
    def print_cell(c)
      result = "-------|\n"
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
