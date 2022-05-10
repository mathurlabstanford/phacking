
library(data.table)
library(devtools)

load_all()

# change to map and feed it to optim

# RUN PACKAGE EXAMPLE (LODDER) -------------------------------------

data(lodder)

res = phacking_rtma(lodder$yi, lodder$vi, parallelize = FALSE)

rtma_qqplot(res)
rtma_cdf(res)

z_density(yi =)


# OTHER METAS -------------------------------------

setwd("~/Dropbox/Personal computer/Reference sheets/Library of prepped example meta-analyses/MW2")

d = fread("flegal_prepped.csv")

res2 = phacking_rtma(d$yi, d$vi, parallelize = FALSE)

rtma_qqplot(res2)
rtma_cdf(res2)

z_density(yi = d$yi, vi = d$vi)

