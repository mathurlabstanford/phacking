
library(data.table)
library(devtools)

load_all()

# RUN PACKAGE EXAMPLE (LODDER) -------------------------------------



# OTHER METAS -------------------------------------

setwd("~/Dropbox/Personal computer/Reference sheets/Library of prepped example meta-analyses/MW2")

d = fread("flegal_prepped.csv")

svalue(yi = d$yi,
       vi = d$vi,
       q = 0,
       model = "robust",
       favor.positive = FALSE,
       return.worst.meta = TRUE)

corrected_meta(yi = d$yi,
               vi = d$vi,
               eta = 15,
               model = "robust",
               favor.positive = FALSE)
