# Contributing guidelines

## Table of contents

- [Code of conduct](#code-of-conduct)
- [Scope](#essential-things-to-know-about-metsymb)
- [Package content](#package-content)
- [Contributing new symbols](#contributing-new-symbols)
- [Updating the metsymb font (maintainers)](#updating-the-metsymb-font)
- [Releasing new symbols (maintainers)](#releasing-new-symbols)


## Code of conduct
This project and everyone participating in it is governed by the [metsymb Code of Conduct](CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code. Please report unacceptable behavior to [frederic.vogt@meteoswiss.ch](mailto:frederic.vogt@meteoswiss.ch).


## Scope

metsymb is being developed inside a dedicated [Github repository](https://github.io/MeteoSwiss/metsymb) under the [MeteoSwiss organization](https://github.io/MeteoSwiss).

User contributions are welcome and will be examined in details. So are bug reports and suggestions for new symbols, which are **best submitted as [Github Issues](https://github.com/MeteoSwiss/metsymb/issues)**.

metsymb is meant to ease the access to vectorial definitions of meteorological symbols used by scientists and engineers. In order to be included in metsymb, symbols should be:
   * formally defined and/or approved by a renowned scientific authority, such as the World Meteorological Organization,
   * used and recognized internationally, and
   * regularly employed in a professional context.

A [dedicated Github issue template](https://github.com/MeteoSwiss/metsymb/blob/develop_vof/.github/ISSUE_TEMPLATE/symbol_suggestion.md) was created to make sure [new symbol requests](https://github.com/MeteoSwiss/metsymb/issues?q=is%3Aissue+%5BSYMB%5D+) are properly motivated.


## Package content

What follows is a (brief) description of the more "exotic" files included in the metsymb repo:
 - `.github/`: contains all the Github-related magic, including custom issue templates, custom
   pull-request templates, and specific Actions for CI/CD purposes.

 - `source/`: contains the actual metsymb TeX package files. These include:
   * `manual_install.sh`: a crude, basic, absolutely-not-to-be-trusted bash script to automate the manual installation of the metsymb TeX package.
   * `metsymb.sfd`: the FontForge save file, used to assign glyphs to characters of the metsymb font.
   * `metsymb.afm`, `metsymb.enc`, `metsymb.pfb`, `metsymb.tfm`, and `metsymb.otf`: the different font files required by LaTeX, generated using FontForge.
   * `umetsymb.fd`, `metsymb.map`, `metsymb.ins`, `metsymb.dtx`: the actual LaTeX package files.
   * `metsymb_mwe.py`, and `metsymb_mwe.mplstyle`: demo files to illustrate the use of metsymb with `matpolotlib`. With metsymb successfully installed, running `metsymb_mwe.py` will generate
   `metsymb_mwe.png` and `metsymb_mwe.pdf`.
   * `metsymb.pdf`: the compiled documentation of the metsymb TeX package.
   * `testfont.pdf`: the metsymb font table (see below).

 - `tickz_glyphs/`: contains all the individual TikZ reference codes for the metsymb glyphs. Each
   glyph is designed inside a dedited `.tex` file, which gets compiled in a matching `.pdf` file.
   The latter is then converted manually (see below) to a matching `.svg` file, that is used to load
   the symbol inside FontForge.

 - `.gitattributes`: fine-tunes which files get included in the Github releases' `.zip`, to ensure these are CTAN-ready.


## Contributing new symbols
The addition of new symbols (or the modification of existing ones) is a three phase process:
   * Creation/modification of the symbol in a stand-alone, custom, LaTeX document using TikZ syntax.
   * Inclusion into the metsymb OpenType font via FontForge.
   * Creation of dedicated LaTeX commands in the metsymb package.

The first step is the hardest one, but also the one where user contributions are the easiest. Here is a detailed walkthrough of what it entails:

0. Fork the metsymb Github repository.

1. [For a new symbol] Create a file `symbol_name.tex` by copying [`tikz_glyphs/blank/blank.tex`](https://github.com/MeteoSwiss/metsymb/tree/master/tikz_glyphs/blank/blank.tex).

2. Use [TikZ commands](https://en.wikipedia.org/wiki/PGF/TikZ) to draw the new symbol. This is the hardest part ! Use custom styles with parsimony. If warranted, new styles should be defined in [`ref_styles.tex`](https://github.com/MeteoSwiss/metsymb/tree/master/tikz_glyphs/ref_styles.tex), in order to make them available to all other symbols, and ease the maintenance of the package.

3. Compile `symbol_name.tex`:
    ```
    pdflatex symbol_name.tex
    ```

4. Convert the resulting PDF to SVG:
    ```
    pdf2svg symbol_name.pdf symbol_name.svg
    ```

5. Submit a Pull Request (that should include `symbol_name.tex`, `symbol_name.pdf`, and `symbol_name.svg`) against the develop branch of the repo.


Once a Pull Request is issued, the metsymb devs will be notified automatically.


## Updating the metsymb font

When a new set of symbols has been assembled, the package maintainers will need to include them in the OpenType metsymb font, and tie them to shortcuts in the metsymb LaTeX package. Here's a step-by-step walkthrough of these tasks:


1. Modify `metsymb.sfd` directly with FontForge.

    1.0. Choose a new/existing glyph, and open the corresponding editor.

    1.1. Import the SVG file of the symbol generated using LaTeX/TikZ. Under `Options`, ensure that
        `Scale to Fit` is selected.

    1.2. Cleanup the glyph via `Element -> Overlap -> Remove Overlap` (after selecting all nodes).
        :warning: If certain elements are "white", their order must first be reversed via `Element -> Reverse Order`.

    1.3. Check the glyph validity via `Elements -> Find Problems ...`. Make sure to tick the box `Paths -> Intersecting paths & Check missing extrema`.

    1.4. Repeat steps 1.1 to 1.3 for each new/updated glyph.

    1.5. Update the font version under `Element -> Font info -> PS Names`.

    1.6. Keep the encoding to `TeX Base (8r)` under `Encoding -> Reencode`.

2. Create the `.tfm`, `.enc`, `.pfb`, `.asm` files by exporting the font via `File -> Generate Fonts ... -> PS Type1 (Binary)` with `Options -> Output TFM & ENC`.

3. Create the `.otf` file by exporting the font via `File -> Generate Fonts... -> OpenType (CFF)`

4. Update `metsymb.dtx`:

   4.1. For new symbols, add new macros under the *Implementation* section.

   4.2. For new symbols, add a dedicated table under the *Usage* section.

   4.3. For new symbols, update the abstract.

   4.4. Adjust the version in `metsymb.dtx` around l.19.

5. Run `latex metsymb.ins`.

6. Copy the following files in the appropriate location of your Tex-tree, in my case (OS X 10.15):
   ```
   cp metsymb.tfm /usr/local/texlive/2020/texmf-dist/fonts/tfm/public/metsymb/
   cp metsymb.afm /usr/local/texlive/2020/texmf-dist/fonts/afm/public/metsymb/
   cp metsymb.pfb /usr/local/texlive/2020/texmf-dist/fonts/type1/public/metsymb/
   cp metsymb.otf /usr/local/texlive/2020/texmf-dist/fonts/opentype/public/metsymb/
   cp umetsymb.fd /usr/local/texlive/2020/texmf-dist/tex/latex/metsymb/
   cp metsymb.sty /usr/local/texlive/2020/texmf-dist/tex/latex/metsymb/
   cp metsymb.map /usr/local/texlive/2020/texmf-dist/fonts/map/dvips/metsymb/
   cp metsymb.enc /usr/local/texlive/2020/texmf-dist/fonts/enc/dvips/metsymb/
   ```

7. Tell TeX about these new files:
    ```
    sudo mktexlsr
    sudo updmap-sys --enable Map metsymb.map
    sudo updmap-sys
    ```

8. Create the font table:
    ```
    pdftex testfont
    ```
    When prompted for the font name, type `metsymb`, then request a `\sample`, and `\bye`.

9. Run the Python example via `python metsymb_mwe.py`.

10. Generate the pdf of the documentation via `pdflatex metsymb.dtx`, and check it carefully.

    :warning: when adding new symbols, the checksum will likely need to be adjusted in `metsymb.dtx`. This value corresponds to the number of `\` in the code. If/when things blow up in your face when compiling the `.dtx` file, just update the checksum value with the one in the error message.

:wave: The bash file `manual_install.sh` can be used to automate steps 5-10 with the command `sh manual_install.sh`. **Mind the TeX-tree paths in there, that will most certainly need to be adjusted to your needs !**


## Releasing new symbols

It is unlikely that metsymb will be subject to a regular release cycle.
As a consequence, the release procedure is --for now at least-- rather manual (:scream:).
Here are the steps to follow, should a new release be warranted:

1. If warranted, update the copyright years in the following files:

        README, LICENSE, metsymb.ins, metsymb.dtx, and metsymb.sfd (via FontForge)

   :warning: Mind the multiple copyright entries in some of these files !

2. Follow all the steps of the previous Section to update all files.

3. If warranted, update the list of authors in `AUTHORS`.

4. Update the CHANGELOG.

5. Issue a Pull Request on Github onto the `master` branch, that will be reviewed by the metsymb devs.

   :warning: Direct commits to `master` are forbidden !

6. Once all has been reviewed and merged, create a new release on Github.

7. Upload the release's `metsymb-vX.Y.Z-ctan.zip` file onto CTAN. This file is being created by a dedicated Action, to make sure it is compliant with the CTAN upload requirements.
