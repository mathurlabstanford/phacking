## Test environments

The package was tested with `R CMD check --as-cran` on the following platforms:

* ubuntu-gcc-devel,
* ubuntu-gcc-release,
* windows-x86_64-devel,
* windows-x86_64-release,
* windows-x86_64-oldrel,
* macos-latest.

## R CMD check results

Most examples are wrapped in `\donttest{}` because they take more than 5s to run.

There were no ERRORs or WARNINGs.

There were 3 NOTEs:

```
Maintainer: ‘Peter Solymos <psolymos@gmail.com>’

New submission

Package was archived on CRAN

CRAN repository db overrides:
  X-CRAN-Comment: Archived on 2023-06-02 as issues were not corrected
    in time.
```

The package has new maintainer and is being submitted after archival.

```
* checking installed package size ... NOTE
  installed size is 41.0Mb
  sub-directories of 1Mb or more:
    libs  40.8Mb
```

The big file is due to the compiled Stan model, which is expected.

```
* checking for GNU extensions in Makefiles ... NOTE
GNU make is a SystemRequirements.
```

GNU make is required by rstan.
