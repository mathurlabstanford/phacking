#' Right-truncated meta-analysis
#'
#' @param yi A vector of point estimates to be meta-analyzed.
#' @param vi A vector of estimated variances for the point estimates.
#' @param sei A vector of estimated standard errors for the point estimates.
#' @param favor_positive \code{TRUE} if phacking is assumed to favor positive
#'   estimates; \code{FALSE} if assumed to favor negative estimates (defaults to
#'   \code{TRUE}).
#' @param alpha_level Alpha level at which
#' @param stan_control List passed to \code{rstan::sampling()} as the
#'   \code{control} argument.
#'
#' @return A list with two elements, \code{stats} and \code{fit}.
#' @export
#'
#' @examples
phacking_rtma <- function(yi,
                          vi,
                          sei,
                          favor_positive = TRUE,
                          alpha_level = 0.05,
                          stan_control = list(adapt_delta = 0.98,
                                              max_treedepth = 20)) {

  if (!favor_positive) yi <- -yi

  if (missing(sei)) {
    assertthat::assert_that(!missing("vi"),
                            msg = "Must specify 'vi' or 'sei' argument.")
    sei <- sqrt(vi)
  }

  k <- length(yi)
  tcrit <- rep(stats::qnorm(1 - alpha_level / 2), k)
  affirm <- as.numeric((yi / sei) > tcrit)
  stan_data <- list(y = yi, sei = sei, k = k, tcrit = tcrit, affirm = affirm)

  options(mc.cores = parallel::detectCores())

  stan_fit <- rstan::sampling(stanmodels$phacking_rtma,
                              cores = 1,
                              refresh = 0,
                              data = stan_data,
                              control = stan_control,
                              init = \() list(mu = 0, tau = 1))

  param_median <- \(p) stats::median(unlist(rstan::extract(stan_fit, p)))

  stan_summary <- rstan::summary(stan_fit)$summary %>%
    dplyr::as_tibble(rownames = "param")

  stan_stats <- stan_summary %>%
    dplyr::filter(.data$param %in% c("mu", "tau")) %>%
    dplyr::select(.data$param, .data$mean, se = .data$se_mean,
                  ci_lower = .data$`2.5%`, ci_upper = .data$`97.5%`,
                  r_hat = .data$Rhat) %>%
    dplyr::mutate(median = c(param_median("mu"), param_median("tau")),
                  .after = .data$param) %>%
    dplyr::mutate(param = .data$param %>%
                    dplyr::recode_factor(mu = "m_hat", tau = "s_hat"))

  return(list(stats = stan_stats, fit = stan_fit))

}
