# Rd
devtools::document()
# Check/update URLS
urlchecker::url_check()

# Check spelling
dict <- hunspell::dictionary('en_US')
devtools::spell_check()
spelling::update_wordlist()

# local checks
# - need checkbashisms to avoid WARNING
# - GNU make NOTE can be ignored --> see cran-comments.md
devtools::check()

# install
devtools::install()

# multi-arch checks
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

# build package to submit
devtools::build()
