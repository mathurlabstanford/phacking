
library(data.table)
library(devtools)
library(here)

setwd(here())

# note: this will not recompile the stan model
# even if you restart R
#  sourcing stanmodels.R also doesn't work, even though stanmodels is then correct
load_all()



# RUN PACKAGE EXAMPLE (LODDER) -------------------------------------

data(lodder)

#@keep only nonaffirmatives; eventually package needs to do this internally
lodder = lodder %>% filter( yi/sqrt(vi) < qnorm(.975) )

res = phacking_rtma(lodder$yi, lodder$vi, parallelize = TRUE)
res$fit

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

