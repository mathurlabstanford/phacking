
library(data.table)
library(devtools)
library(here)
library(stats4)

setwd(here())



# note: this will not recompile the stan model
# for that, run Build > Clean and Rebuild from RStudio menu
load_all()


# HELPERS -------------------------------------

# log-likelihood for single observation or vector
simple_lli = function(yi,
                      sei,
                      mu,
                      tau,
                      tcrit ) {

  Si = sqrt(tau^2 + sei^2)
  cz = (tcrit*sei - mu)/Si

  -log( Si* sqrt(2*pi) ) - 0.5 * Si^(-2) * (yi-mu)^2 - log( pnorm(cz) )
}


# joint prior, not yet logged
# should only pass the sei from the nonaffirmative studies
prior_simp = function(mu, tau, sei, tcrit) {

  k = length(sei)
  if ( length(tcrit) < k ) stop("tcrit must be vector of length k")

  # this will be the TOTALS for all observations
  fishinfototal = matrix( 0, nrow = 2, ncol = 2 )

  # build a Fisher info matrix for EACH observation
  # for-loop is definitely not the most efficient way to do this
  for (i in 1:k) {

    # for this observation
    fishinfo = matrix( NA, nrow = 2, ncol = 2 )

    Si = sqrt( tau^2 + sei[i]^2 )
    cz = (sei[i] * tcrit[i] - mu) / Si
    dnor = dnorm(cz) # can't use log on this in case it's negative
    pnor = pnorm(cz)
    r = dnor/pnor

    kmm = Si^(-2)*(cz*r + r^2 - 1)
    kms = tau*Si^(-3)*r*( cz^2 + cz*r + 1 )
    kss = ( tau^2 * Si^(-4) ) * ( cz^3*r + cz^2*r^2 + cz*r - 2 )

    fishinfo[1,1] = -kmm
    fishinfo[1,2] = -kms
    fishinfo[2,1] = -kms
    fishinfo[2,2] = -kss

    # add the new Fisher info to the total one
    fishinfototal = fishinfototal + fishinfo
  }

  return( list(Efish = fishinfototal,
               det = det(fishinfototal),
               prior = sqrt( det(fishinfototal) ) ) )
}



# joint negative log-posterior
# this fn is set up for use with mle(), which is a bit of a PITA
# e.g., it doesn't want the fn to be optimized to take other args besides the ones to be optimized
# so here yi, sei, etc., are scoped globally
nlpost_simple = function(.mu, .tau) {

  joint_ll = sum( simple_lli(yi = yi,
                             sei = sei,
                             tcrit = tcrit,
                             mu = .mu,
                             tau = .tau) )

  joint_lprior = sum( log( prior_simp(sei = sei,
                                      tcrit = tcrit,
                                      mu = .mu,
                                      tau = .tau)$prior ) )

  -joint_ll - joint_lprior
}



# RUN PACKAGE EXAMPLE (LODDER) -------------------------------------

data(lodder)

#***keep only nonaffirmatives; eventually package needs to do this internally
lodder = lodder %>% filter( yi/sqrt(vi) < qnorm(.975) )


# ~ Illustrate estimation of posterior modes -------------------------------------

# because of nlpost_simple's use of global vars
yi = lodder$yi
sei = sqrt(lodder$vi)
tcrit = rep(qnorm(.975), length(yi))


# mle() is just a wrapper for optim()
( mle.obj = stats4::mle( minuslogl = nlpost_simple,
               #***start values should be changed to be the max-lp-iterate values from the stan model
               start = list(.mu = 0, .tau = 1),
               method = "Nelder-Mead" ) )

# recode convergence more intuitively
# optim uses "0" to mean successful convergence
optim.converged = attr(mle.obj, "details")$convergence == 0


# ~ Run MCMC to get credible interval -------------------------------------

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

