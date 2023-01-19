## Test environments
- local OSX install (R 4.1.3)
- Windows Server 2022, R-devel, 64 bit (on R-hub)
- Ubuntu Linux 20.04.1 LTS, R-release, GCC (on R-hub)
- Fedora Linux, R-devel, clang, gfortran (on R-hub)


## R CMD check results

Most examples are wrapped in `\donttest{}` because they take more than 5s to run.

There were no ERRORs or WARNINGs.

There were 2 NOTEs:

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
