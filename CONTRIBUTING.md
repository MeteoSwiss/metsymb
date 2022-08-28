# Contributing guidelines

## Table of contents

- [Code of conduct](#code-of-conduct)
- [Scope](#essential-things-to-know-about-metsymb)
- [Contributing new symbols](#contributing-new-symbols)
- [Updating the metsymb font (maintainers)](#updating-the-metsymb-font)
- [Releasing new symbols (maintainers)](#releasing-new-symbols)


## Code of conduct
This project and everyone participating in it is governed by the [metsymb Code of Conduct](CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code. Please report unacceptable behavior to [frederic.vogt@meteoswiss.ch](mailto:frederic.vogt@meteoswiss.ch).


## Scope

`metsymb` is being developed inside a dedicated [Github repository](https://github.io/MeteoSwiss/metsymb) under the [MeteoSwiss organization](https://github.io/MeteoSwiss).

User contributions are welcome and will be examined in details. So are bug reports and suggestions for new symbols, which are **best submitted as [Github Issues](https://github.com/MeteoSwiss/metsymb/issues)**.

`metsymb` is meant to ease the access to vectorial definitions of meteorological symbols used by scientists and engineers. In order to be included in `metsymb`, symbols should be:
   * formally defined and/or approved by a renowned scientific authority, such as the World Meteorological Organization,
   * used and recognized internationally, and
   * typically employed in a professional context.

Here is a non-exhaustive list of symbols that will never be included in `metsymb`: :cloud:, :zap:, :cyclone:, :snowflake:, ... :scream: !


## Contributing new symbols
The addition of new symbols (or the modification of existing ones) is a three phase process:

A. Creation/modification of the symbol in a stand-alone, custom, LaTeX document using TikZ syntax.

B. Inclusion into the metsymb OpenType font via FontForge.

C. Creation of dedicated LaTeX commands in the metsymb package.

The first step is the hardest one, but also the where user contributions are the easiest. Here is a detailed walkthrough of what it entails:

1. [For a new symbol] Create a file `symbol_name.tex` by copying `tikz_glyphs/dummy/dummy.tex`.

2. Use TikZ to draw the new symbol. This is the hardest part ! Use custom styles with parcimony. If warranted, new styles should be stored in `ref_styl.tex`, in order to make them available to all other symbols, and ease the maintenance of the package.

3. Compile `symbol_name.tex` using:

    pdflatex symbol_name.tex

4. Convert the resulting PDF to SVG via:

    pdf2svg symbol_name.pdf symbol_name.svg

5. Submit a Pull Request against the develop branch of the repo, and wait for the `metsymb` devs to show up.


## Updating the metsymb font

When a new set of symbols has been assembled, the package maintainers will need to include them in the OpenType `metsymb` font, and tie them to shortcuts in the `metsymb` LaTeX package. Here's a step-by-step walkthrough of these tasks:


1. Modify `metsymb.sfd` directly with FontForge.

   * for a given glyph, import the corresponding SVG file. Ensure to "scale it to fit". The inclusion of a white box in the corresponding `symbol_name.tex` file should ensure the scaling is correct. This white box must then be removed manually in FontForge.

   * update the font version under *Element->Font info->PS Names*.

   * update the log under *Element->Font info->FONTLOG*.

   * keep the encoding to `TeX Base (8r)` under *Encoding->Reencode*.

2. Create the `.tfm`, `.enc`, `.pfb`, `.asm` files by exporting the font via *File->Generate Fonts...->PS Type1 (Binary)* with *Options->Output TFM & ENC*.

3. Create the `.otf` file by exporting the font via *File->Generate Fonts...->OpenType (CFF)*

4. *(for new symbols)* Modify `metsymb.dtx`:

   * add new macros under the Implementation section.

   * add new tables under the Usage section.

   * update the abstract.

5. *Update* the version in `metsymb.dtx` around l.19, and *add* the change around l.72.

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

8. Run the Python mwe with `python metsymb_mwe.py`.

9. Create the font test table with `pdftex testfont` with the `\sample` and `\bye` commands.

10. Generate the pdf of the documentation with `pdflatex metsymb.dtx`, and check it carefully.

    :warning: when adding new symbols, the checksum will likely need to be adjusted in `metsymb.dtx`. This value corresponds to the number of `\` in the code. If things blow up in your face when compiling the `.dtx` file, just update the checksum value with the one in the error message.

:wave: *(side note)* The bash file `manual_install.sh` can be used to automate steps 5-7 with the command `sh manual_install.sh`. **Mind the TeX-tree paths in there, that will most certainly need to be adjusted to your needs !**


## Releasing new symbols

It is unlikely that `metsymb` will be subject to a regular *release* cycle given its (very) humble nature. As a consequence, the release procedure is --for now at least-- rather manual (:scream:). Here are the steps to follow, should a new release be warranted:

1. *(if applicable)* Update the copyright years in the following files:

        README, LICENSE, metsymb.ins, metsymb.dts, and metsymb.sfd (via FontForge)

   :warning: Mind the multiple copyright entries in those files !

2. Follow all the steps of the previous Section to update all files.

3. *(if applicable)* Update the list of authors in `AUTHORS`.

4. Issue a Pull Request on Github onto the `master` branch, that will be reviewed by the metsymb devs.

   :warning: Direct commits to `master` are forbidden !

5. *(for the devs)* Review the Pull Request.

6. *(for the devs)* Create a new release on Github.

7. *(for the devs)* Upload the release's `.zip` onto CTAN.
