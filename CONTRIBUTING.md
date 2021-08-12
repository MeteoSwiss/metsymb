# Contributing guidelines

`oktasymb` is being developped inside a dedicated Github repository under the MeteoSwiss organization, located at: https://github.io/MeteoSwiss/oktasymb

User contributions are welcome and will be examined in details. So are bug reports, which are **best submitted as Github Issues** directly on the code's repo at: https://github.com/MeteoSwiss/oktasymb/issues.


## Release mechanism
It is unlikely that `oktasymb` will be subject to a regular *update-and-release* cycle given its (very) humble nature. As a consequence, the release procedure is --for now at least-- rather manual. Here are the steps to follow, should a new release be warranted:

1. *(if applicable)* Update the copyright years in the following files:
    
        README, LICENSE, oktasymb.ins, and oktasymb.dts

   :warning: mind the multiple copyright entries in those files !

2. *(if applicable)* Update the list of authors in `AUTHORS`

3. Run:
        
        pdftex oktasymb.dtx
   and:
    - check that the resulting pdf is correct
    - check the log to make sure the checksum is correct (modify it in `oktasymb.dtx` if warranted).

      *Side-note: the checksum corresponds to the number of `\` in the code. If the code changed, chances are the checksum will have changed too.*

4. Run:

        latex oktasymb.ins
   and:
   - check that all goes well when generating `oktasymb.sty`

5. Create a new release on Github.
6. Upload the release's `.zip` onto CTAN.

   ❓Can this actually be done ? Hopefully the CONTRIBUTING.md and LICENSE files will not be an issue for CTAN.
