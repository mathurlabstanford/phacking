## Test environments
- macos-latest release (on macbuilder)
- windows-latest release (on winbuilder)
- windows-latest devel (on winbuilder)


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
