library(rhub)
#validate_email("peter@analythium.io")
platforms()
f <- c("ubuntu-gcc-devel",
       "ubuntu-gcc-release",
       "windows-x86_64-devel",
       "windows-x86_64-release",
       "windows-x86_64-oldrel")
check(platform=f)
list_package_checks(".")

pkgnews <- function() {
        x <- readLines("NEWS.md")
        x <- x[x != ""]
        h <- which(startsWith(x, "#"))
        i <- (h[1]+1):(h[2]-1)
        paste0(x[i], collapse="\n")
    }
cat(sprintf('Dear CRAN Maintainers,

I am submitting the %s version of the %s R extension package to CRAN.

## Changelog

We made the following changes since the last release:

%s

%s

Yours,

Peter Solymos
maintainer',
       read.dcf("DESCRIPTION", fields="Version")[1],
       read.dcf("DESCRIPTION", fields="Package")[1],
       pkgnews(),
       paste0(readLines("cran-comments.md"), collapse="\n")))
