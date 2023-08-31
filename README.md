# metsymb

[![DOI](https://zenodo.org/badge/395373932.svg)](https://zenodo.org/badge/latestdoi/395373932)

metsymb is a **LaTeX package** that introduces vectorial definitions of official meteorological symbols. Individual symbols are first designed using [TikZ](https://www.ctan.org/pkg/pgf). They are then bundled into a dedicated font with [FontForge](https://fontforge.org/en-US/), and eventually tied to dedicted LaTeX commands. The metsymb **OpenType font** is a side-product that can be used on its own.

This README contains information about the metsymb source code and [repository](https://github.com/MeteoSwiss/metsymb).

**For the description of the metsymb LaTeX package, see [this file](https://github.com/MeteoSwiss/metsymb/blob/develop/source/metsymb.pdf).**


## Table of contents

- [License and Copyright](#license-and-copyright)
- [Installation](#installation)
- [Troubleshooting and bug reports](#troubleshooting-and-bug-reports)
- [Suggesting new symbols](#suggesting-new-symbols)
- [Contributing](#contributing)


## License and Copyright

The metsymb package is released under the terms of the BSD-3-Clause license. The terms of this license are available at https://opensource.org/licenses/BSD-3-Clause, and in the LICENSE file included in the package.

The copyright (C) 2021-2023 of metsymb is owned by MeteoSwiss. The contributors to the code are listed in AUTHORS.


## Installation

Depending on your needs, you may want to install metsymb:
- [as a LaTeX package](#install-metsymb-as-a-latex-package), or
- [as an OpenType font](#install-metsymb-as-an-opentype-font)


### Install metsymb as a LaTeX package
Since metsymb includes a new font, its manual installation is a bit hairier (:scream:) than regular packages. **It is thus strongly recommended to use your favorite TeX package
manager to install metsymb, given that it lives on [CTAN](https://ctan.org/pkg/metsymb)**.

Should you be willing/required to install the package manually nonetheless, here are some guidelines:

  1. Download the latest metsymb [release](https://github.com/MeteoSwiss/metsymb/releases).
     If you are interested in the latest changes, you can also clone the [metsymb Github repo](https://github.com/MeteoSwiss/metsymb) directly.

  2. Create the TeX `.sty` file:
     ```
     cd some/path/to/metsymb/source/
     latex metsymb.ins
     ```

  3. Many of the package files will need to be placed under specific locations within your TeX-tree,
     which I shall call `tex_loc` for simplicity.

     In my case (Mac OSX 10.15), `tex_loc = /usr/local/texlive/2020/texmf-dist/`. To find your own `tex_loc`, you can try the following command: `kpsewhich --var-value=TEXMFLOCAL`. In case of trouble, the following resources may prove useful:
       * https://tex.stackexchange.com/questions/88423/manual-font-installation
       * https://tug.org/fonts/fontinstall.html

     Having identified your `tex_loc`, place the following files where they belong in the tree:
     ```
     cp metsymb.tfm tex_loc/fonts/tfm/public/metsymb/
     cp metsymb.afm tex_loc/fonts/afm/public/metsymb/
     cp metsymb.pfb tex_loc/fonts/type1/public/metsymb/
     cp metsymb.otf tex_loc/fonts/opentype/public/metsymb/
     cp umetsymb.fd tex_loc/tex/latex/metsymb/
     cp metsymb.sty tex_loc/tex/latex/metsymb/
     cp metsymb.map tex_loc/fonts/map/dvips/metsymb/
     cp metsymb.enc tex_loc/fonts/enc/dvips/metsymb/
     ```

  4. At this point, we need to tell TeX about these new files. Run the following commands to do so:
     ```
     sudo mktexlsr
     sudo updmap-sys --enable Map metsymb.map
     sudo updmap-sys
     ```
     :warning: `sudo` is required under OS X, but not necessarily elsewhere ?

     :wave: The bash file `manual_install.sh` can be used to automate these different steps with the command `sh manual_install.sh`. Before you run it blindly, **mind the TeX-tree paths in there, that will most certainly need to be adjusted to your needs !**

And that's it !

You should now be able to compile the metsymb documentation with the command: `pdflatex metsymb.dtx`.

You should also be able to run the Python example with the command: `python metsymb_mwe.py`.

If these two commands work, you have successfully installed the metsymb package manually, and can now access it in your LateX documents and matplotlib figures. :tada:


### Installing metsymb as an OpenType font

Deploy the [`metsymb.otf`](https://github.com/MeteoSwiss/metsymb/blob/develop/source/metsymb.otf) file on your system like you would any other OpenType font, and you should
have access to its symbols in your favorite text editor.


## Troubleshooting and bug reports

If you encounter any issue when installing or using metsymb, you can check if it has already been reported [here](https://github.com/MeteoSwiss/metsymb/issues?q=is%3Aissue). If not, please create a new [Github Issue](https://github.com/MeteoSwiss/metsymb/issues) to report it and get help.


## Suggesting new symbols

If your favorite meteorological symbol is not yet included in metsymb,
you can suggest its inclusion by creating a new [Discussion on Github](https://github.com/MeteoSwiss/metsymb/discussions/categories/symbol-suggestions).


## Contributing

If you simply cannot wait to see your favorite symbol included inside metsymb, you should check our [contributing guidelines](CONTRIBUTING.md).
