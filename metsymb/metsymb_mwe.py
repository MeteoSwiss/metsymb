# -*- coding: utf-8 -*-
"""
Copyright (C) 2021 MeteoSwiss,
originally written by F.P.A. Vogt; frederic.vogt@meteoswiss.ch

This file may be distributed and/or modified under the conditions
of the BSD-3-Clause License.
The terms of this license are available at:

https://opensource.org/licenses/BSD-3-Clause

SPDX-License-Identifier: BSD-3-Clause

Module content: minimal working example of the metsymb LaTeX package
with matplotlib figures.
"""

# Import matplotlib
from matplotlib import pyplot as plt

# Set the proper rcparams elements
plt.style.use('./metsymb_mwe.mplstyle')

# Create a basic figure with some demo text in the center.
plt.close(1)
plt.figure(1, figsize=(4, 0.5))
plt.text(0.5, 0.5,
         r'\LARGE Hello World: \threeoktas \nimbostratus \chIX',
         ha='center')
plt.axis('off')

# Export to different format and display on-screen.
plt.savefig('metsymb_mwe.pdf')
plt.savefig('metsymb_mwe.png')
#plt.show()
