#' Right-truncated meta-analysis
#'
#' @param yi A vector of point estimates to be meta-analyzed.
#' @param vi A vector of estimated variances (i.e., squared standard errors) for the point estimates.
#' @param sei A vector of estimated standard errors for the point estimates. (Only one of \code{vi} or \code{sei} needs to be specified).
#' @param favor_positive \code{TRUE} if p-hacking and publication bias are assumed to favor significant positive
#'   estimates; \code{FALSE} if assumed to favor significant negative estimates.
#' @param alpha_select Alpha level at which an estimate's probability of being favored by p-hacking and/or by publication bias is assumed to change (i.e., the threshold at which study investigators, journal editors, etc., consider an estimate to be signficant).
#' @param stan_control List passed to \code{rstan::sampling()} as the
#'   \code{control} argument.
#' @param parallelize Logical indicating whether to parallelize sampling.
#'
#' @return A list with three elements, \code{values}, \code{stats} and
#'   \code{fit}.
#' @export
#'
#' @examples
#' phacking_rtma(lodder$yi, lodder$vi, parallelize = FALSE)
phacking_rtma <- function(yi,
                          vi,
                          sei,
                          favor_positive = TRUE,
                          alpha_select = 0.05,
                          stan_control = list(adapt_delta = 0.98,
                                              max_treedepth = 20),
                          parallelize = TRUE) {

  if (!favor_positive) yi <- -yi

  if (missing(vi) & missing(sei)) stop("Must specify 'vi' or 'sei' argument.")
  if (missing(vi)) vi <- sei ^ 2
  if (missing(sei)) sei <- sqrt(vi)

  k <- length(yi)
  tcrit <- qnorm(1 - alpha_select / 2)
  affirm <- (yi / sei) > tcrit
  stan_data <- list(y = yi, sei = sei, k = k,
                    tcrit = rep(tcrit, k))

  values <- list(
    k = k,
    k_affirmative = sum(affirm),
    k_nonaffirmative = sum(!affirm),
    favor_positive = favor_positive,
    alpha_select = alpha_select,
    tcrit = tcrit,
    yi = yi,
    vi = vi,
    sei = sei,
    affirm = affirm
  )

  if (parallelize) options(mc.cores = parallel::detectCores())
  stan_fit <- rstan::sampling(stanmodels$phacking_rtma,
                              data = stan_data,
                              control = stan_control,
                              init = function() list(mu = 0, tau = 1))

  param_median <- function(p) median(unlist(rstan::extract(stan_fit, p)))

  ## MM extracts max-lp iterate
  ext = rstan::extract(stan_fit) # a vector of all post-WU iterates across all chains
  best.ind = which.max(ext$log_post)  # single iterate with best log-posterior should be very close to MAP
  # posterior means, posterior medians, and max-LP iterate
  muhat_maxlp = ext$mu[best.ind]
  tauhat_maxlp = ext$tau[best.ind]

  # we'd then pass (muhat_maxlp, tauhat_maxlp) to mle() to find the actual posterior mode
  ## end MM

  stan_summary <- rstan::summary(stan_fit)$summary %>%
    as_tibble(rownames = "param")

  stan_stats <- stan_summary %>%
    filter(.data$param %in% c("mu", "tau")) %>%
    select(.data$param, .data$mean, se = .data$se_mean, ci_lower = .data$`2.5%`,
           ci_upper = .data$`97.5%`, r_hat = .data$Rhat) %>%
    mutate(median = c(param_median("mu"), param_median("tau")),
           .after = .data$param)

  return(list(values = values, stats = stan_stats, fit = stan_fit))

}
