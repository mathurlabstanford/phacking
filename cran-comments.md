## Test environments
- local OSX install (R 4.1.3)
- Windows Server 2022, R-devel, 64 bit (on R-hub)
- Ubuntu Linux 20.04.1 LTS, R-release, GCC (on R-hub)
- Fedora Linux, R-devel, clang, gfortran (on R-hub)


## R CMD check results

Most examples are wrapped in `\donttest{}` because they take more than 5s to run.

There were no ERRORs or WARNINGs.

There were 4 NOTEs:

```
* checking CRAN incoming feasibility ... NOTE
Maintainer: 'Mika Braginsky <mika.br@gmail.com>'

New submission

Possibly misspelled words in DESCRIPTION:
  Mathur (11:34, 25:59)
  RTMA (7:50, 22:28)
  nonaffirmative (17:53, 20:10, 21:28, 23:3)
  unhacked (21:60)
```

This is a new package. None of these are actually misspellings.


```
* checking dependencies in R code ... NOTE
Namespaces in Imports field not imported from:
  'RcppParallel' 'rstantools'
  All declared Imports should be used.
```

These packages are all used.


```
* checking for GNU extensions in Makefiles ... NOTE
GNU make is a SystemRequirements.
```

GNU make is required by rstan.


```
* checking for detritus in the temp directory ... NOTE
Found the following files/directories:
  'lastMiKTeXException'
```

As noted in R-hub issue #503, this could be due to a bug/crash in MiKTeX and can likely be ignored.
