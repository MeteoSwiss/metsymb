# The oktasymb package

`oktasymb` is a humble LaTeX package that introduces ten symbols for the different okta integer values, used in meteorology to characterize the fraction of the sky covered by clouds.

`oktasymb` relies on the `tikz` LaTeX package to draw the symbols.

## Manual installation

The "source" files of `oktasymb` are comprised of `oktasymb.ins` and `oktasymb.dtx`. To install the package manually, place these files in a location of your choice and run in a terminal:

    latex oktasymb.ins

This will create the file `oktasymb.sty`, which you should move in a directory visible to your TeX installation (or right next to the LaTeX document in which you import the package). 

To produce the `.pdf` of the documentation, run:

    pdftex oktasymb.dtx

## License & Copyright

The `oktasymb` package is released under the terms of the BSD-3-Clause license. The terms of this license are available at https://opensource.org/licenses/BSD-3-Clause, and under the LICENSE file included in the package.

The copyright (C) 2021 of `oktasymb` is owned by MeteoSwiss. The contributors to the code are listed in AUTHORS. 
