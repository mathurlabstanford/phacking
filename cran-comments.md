## Test environments

The package was tested with `R CMD check --as-cran` on the following platforms:

* Ubuntu Linux GCC (oldrel, release, devel),
* Windows x86_64  (oldrel, release, devel),
* MacOS (release).

## R CMD check results

Most examples are wrapped in `\donttest{}` because they take more than 5s to run.

There were no ERRORs or WARNINGs.

There were 3 NOTEs:

```
Maintainer: ‘Peter Solymos <peter@analythium.io>’

New submission

Package was archived on CRAN

CRAN repository db overrides:
  X-CRAN-Comment: Archived on 2023-06-02 as issues were not corrected
    in time.
```

The package has new maintainer and is being submitted after archival. See more detailes below.

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

The package was previously removed from CRAN because tests took too long:

```
* checking tests ... [38m] OK

This is way too long.

Please reduce the test timings by using
  - small toy data only
  - few iterations
  - or by running less important tests only conditionally if some
environment variable is set that you only define on your machine?

Note that the whole package check time should be less than 10 min.
```

This is now addressed and tests take less than 10 minutes.

From the most recent failed CRAN submission:

```
Please add \value to .Rd files regarding exported methods and explain
the functions results in the documentation. Please write about the
structure of the output (class) and also what the output means. (If a
function does not return a value, please document that too, e.g.
\value{No return value, called for side effects} or similar)
Missing Rd-tags:
      rtma_qqplot.Rd: \value
      z_density.Rd: \value
```

We added `\value` sections to the documentation.

```
Please ensure that you do not use more than 2 cores in your examples,
vignettes, etc.
```

We checked all examples to make sure only 1 core is used via `parallelize = FALSE` that makes sure only 1 core is used.
