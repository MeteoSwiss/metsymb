# Contributing guidelines

## Release mechanism
I expect to release new version of this package only rarely after the first release. Here are the (very manual!) steps I have followed so far:

- update the copyright years in the README, LICENSE, oktasymb.ins, and oktasymb.dts (midnight the multiple copyright entries in those files !)

- update the authors in AUTHORS

- run pdftex oktasymb.dtx and:
  - check that the output is correct
  - check the log to make sure the checksum is correct (modify if warranted)

- run latex oktasymb.ins, and:
  - check that all goes well