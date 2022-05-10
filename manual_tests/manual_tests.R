
library(data.table)
library(devtools)
library(here)

setwd(here())
load_all()

# - I updated prior
# only use nonaffirms in RTMA fitting

# RUN PACKAGE EXAMPLE (LODDER) -------------------------------------

data(lodder)

res = phacking_rtma(lodder$yi, lodder$vi, parallelize = FALSE)

rtma_qqplot(res)
rtma_cdf(res)

z_density(yi = lodder$yi, vi = lodder$vi)



# OTHER METAS -------------------------------------

setwd("~/Dropbox/Personal computer/Reference sheets/Library of prepped example meta-analyses/MW2")

d = fread("flegal_prepped.csv")

res2 = phacking_rtma(d$yi, d$vi, parallelize = FALSE)

rtma_qqplot(res2)
rtma_cdf(res2)

# here, the geom_annotation overlaps with the smoothed density
z_density(yi = d$yi, vi = d$vi)

