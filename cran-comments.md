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

There were 2 NOTEs:

These packages are all used.

```
* checking for GNU extensions in Makefiles ... NOTE
GNU make is a SystemRequirements.
```

GNU make is required by rstan.
