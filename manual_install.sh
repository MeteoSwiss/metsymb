#Copyright (C) 2021 MeteoSwiss,
#originally written by F.P.A. Vogt; frederic.vogt@meteoswiss.ch
#
#This file may be distributed and/or modified under the conditions
#of the BSD-3-Clause License.
#The terms of this license are available at:
#
#https://opensource.org/licenses/BSD-3-Clause
#
#SPDX-License-Identifier: BSD-3-Clause
#
# This (very crude and stupid!) bash file aims at easing the manual installation of metsymb.
#
# WARNING: mind the TeX-tree locations, which will most certainly need to be adjusted to your own
# needs, should you be daring enough to use this script.
#

# Generate the '.sty' file
latex metsymb.ins

# Copy things at the prope location within the TeX tree.
cp "metsymb.tfm" "/usr/local/texlive/2020/texmf-dist/fonts/tfm/public/metsymb/"
cp "metsymb.afm" "/usr/local/texlive/2020/texmf-dist/fonts/afm/public/metsymb/"
cp "metsymb.pfb" "/usr/local/texlive/2020/texmf-dist/fonts/type1/public/metsymb/"
cp "metsymb.otf" "/usr/local/texlive/2020/texmf-dist/fonts/opentype/public/metsymb/"
cp "umetsymb.fd" "/usr/local/texlive/2020/texmf-dist/tex/latex/metsymb/"
cp "metsymb.sty" "/usr/local/texlive/2020/texmf-dist/tex/latex/metsymb/"
cp "metsymb.map" "/usr/local/texlive/2020/texmf-dist/fonts/map/dvips/metsymb/"
cp "metsymb.enc" "/usr/local/texlive/2020/texmf-dist/fonts/enc/dvips/metsymb/"

# Make sure TeX knows about these new elements
sudo mktexlsr
sudo updmap-sys --enable Map metsymb.map
sudo updmap-sys

# Compile the docs to make sure it all works. 
pdflatex metsymb.dtx
