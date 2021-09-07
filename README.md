# The metsymb LaTeX package

`metsymb` is a humble LaTeX package that introduces new meteorological symbols. At the core of the package lies the `metsymb` *font*, in which the different symbols get assigned to specific glyphs, that can then be called via dedicated LaTeX commands.

## Manual installation

Since `metsymb` includes a new font, its manual installation is a bit hairier (:scream:) than regular packages. **The plan is to facilitate an automatic installation with official TeX package managers via the upload of the package to the CTAN repository**. Until that actually happens, or if you are dying to do things by hand, here are some guidelines.

First, let's create the `.sty` file from the package files. Run `latex metsymb.ins`.

The entire package is actually comprised of a series of distinct files:
 - `metsymb.sfd`: the FontForge save file with all the glyphs. Useful only for dev work.
 - `metsymb.afm`, `metsymb.enc`, `metsymb.pfb`, `metsymb.tfm`, and `metsymb.otf`: the different font files required by LaTeX, generated using FontForge.
 - `umetsymb.fd`, `metsymb.map`, `metsymb.ins`, `metsymb.dtx`, and (your newly created) `metsymb.sty`: the actual LaTeX package files.
 - `metsymb_mwe.py`, and `metsymb_mwe.mplstyle`: demo files to illustrate the use of `metsymb` with `matpolotlib`.

To install the package and associated font, many of these files will need to be placed under specific locations within your TeX-tree, which I shall call `tex_loc` for simplicity.

In my case (Mac OSX 10.15), `tex_loc = /usr/local/texlive/2020/texmf-dist/`. To find your `tex_loc`, you can try the following command: `kpsewhich --var-value=TEXMFLOCAL`. In case of trouble, the following resources may prove useful:
 - https://tex.stackexchange.com/questions/88423/manual-font-installation
 - https://tug.org/fonts/fontinstall.html

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

At this point, we need to tell TeX about these new files. Run the following commands to do so:
```
sudo mktexlsr
sudo updmap-sys --enable Map metsymb.map
sudo updmap-sys
```
:warning: `sudo` is required under OS X, but not necessarily elsewhere ?

:wave: *(side note)* The bash file `manual_install.sh` can be used to automate these different steps with the command `sh manual_install.sh`. Before you run it blindly, **mind the TeX-tree paths in there, that will most certainly need to be adjusted to your needs !**

And that's it !

You should now be able to compile the `metsymb` documentation with the command: `pdflatex metsymb.dtx`.

You should also be able to run the Python example with the command: `python metsymb_mwe.py`.

If these two commands work, you have successfully installed the `metsymb` package manually, and can now access it in your LateX documents and matplotlib figures. :tada:

If not ...

## Installation problems, bug reports, and symbol suggestions

For any of these, please use Github Issues at https://github.com/MeteoSwiss/metsymb/issues to get in touch with the package developers.

## License & Copyright

The `metsymb` package is released under the terms of the BSD-3-Clause license. The terms of this license are available at https://opensource.org/licenses/BSD-3-Clause, and under the LICENSE file included in the package.

The copyright (C) 2021 of `metsymb` is owned by MeteoSwiss. The contributors to the code are listed in AUTHORS.
