# Contributing guidelines

`metsymb` is being developed inside a dedicated Github repository under the MeteoSwiss organization, located at: https://github.io/MeteoSwiss/metsymb

User contributions are welcome and will be examined in details. So are bug reports and suggestions for new symbols, which are **best submitted as Github Issues** directly on the code's repo at: https://github.com/MeteoSwiss/metsymb/issues.


## Adding new symbols
The addition of new symbols (or the modification of existing ones) is a two phase process. One must first add (modify) them in the `metsymb` **font** using FontForge, before adjusting the LaTeX commands of the `metsymb` **package** accordingly. The required steps to do so are as follows.

1. Modify `metsymb.sfd` directly with FontForge.

   :point_right: update the font version under *Element->Font info->PS Names*.

   :point_right: update the log under *Element->Font info->FONTLOG*.

   :point_right: keep the encoding to `TeX Base (8r)` under *Encoding->Reencode*.

2. Create the `.tfm`, `.enc`, `.pfb`, `.asm` files by exporting the font via *File->Generate Fonts...->PS Type1 (Binary)* with *Options->Output TFM & ENC*.

3. Create the `.otf` file by exporting the font via *File->Generate Fonts...->OpenType (CFF)*

4. *(for new symbols)* Modify `metsymb.dtx`:

   :point_right: add new macros under the Implementation section.

   :point_right: add new tables under the Usage section.

   :point_right: update the abstract.

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

9. Create the font test table with `pdflatex testfont` with the `\sample` and `\bye` commands.

10. Generate the pdf of the documentation with `pdflatex metsymb.dtx`, and check it carefully.

    :warning: when adding new symbols, the checksum will likely need to be adjusted in `metsymb.dtx`. This value corresponds to the number of `\` in the code. If things blow up in your face when compiling the `.dtx` file, just update the checksum value with the one in the error message.

:wave: *(side note)* The bash file `manual_install.sh` can be used to automate steps 5-7 with the command `sh manual_install.sh`. **Mind the TeX-tree paths in there, that will most certainly need to be adjusted to your needs !**


## Creating new releases

It is unlikely that `metsymb` will be subject to a regular *release* cycle given its (very) humble nature. As a consequence, the release procedure is --for now at least-- rather manual (:scream:). Here are the steps to follow, should a new release be warranted:

###
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
