#!/bin/bash

# Usage
# export IMAGE="rhub/ubuntu-release"
# docker pull $IMAGE
# docker run -it --rm -v $PWD:/home/root/phacking -w /home/root $IMAGE /bin/bash phacking/check.sh

R -q -e "install.packages('devtools')"
R -q -e "remotes::install_deps('phacking')"
R CMD build phacking
R_CHECK_DONTTEST_EXAMPLES=false R CMD check --no-manual --no-tests phacking_*.tar.gz
