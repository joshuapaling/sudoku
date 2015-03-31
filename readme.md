Just so I feel like I don't have to do a sudoku ever again.

In game#apply_all_techniques, rather than looping through all cells and applying each technique, loop through all techniques and then apply it to each cell. It doesn't work. Check why. We've made the find_fucked_cell method for this purpose.

Revert back to the previous commit if things get too messed up.

Need to implement a kinda global 'Stop' method, maybe as a global var, to stop everything for debugging purposes.

NEXT: ditch all changes. Provide solutions, optionally. Pass the 'solved' value through to a cell.
The second the 'solved' value is eliminated, throw an exception.