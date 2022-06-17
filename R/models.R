#' Right-truncated meta-analysis
#'
#' Fits right-truncated meta-analysis (RTMA), a bias correction for the joint
#' effects of p-hacking (i.e., manipulation of results within studies to obtain
#' significant, positive estimates) and traditional publication bias (i.e., the
#' selective publication of studies with significant, positive results) in
#' meta-analyses.
#'
#' @param yi A vector of point estimates to be meta-analyzed.
#' @param vi A vector of estimated variances (i.e., squared standard errors) for
#'   the point estimates.
#' @param sei A vector of estimated standard errors for the point estimates.
#'   (Only one of \code{vi} or \code{sei} needs to be specified).
#' @param favor_positive \code{TRUE} if p-hacking and publication bias are
#'   assumed to favor significant positive estimates; \code{FALSE} if assumed to
#'   favor significant negative estimates.
#' @param alpha_select Alpha level at which an estimate's probability of being
#'   favored by p-hacking and/or by publication bias is assumed to change (i.e.,
#'   the threshold at which study investigators, journal editors, etc., consider
#'   an estimate to be significant).
#' @param stan_control List passed to \code{rstan::sampling()} as the
#'   \code{control} argument.
#' @param parallelize Logical indicating whether to parallelize sampling.
#'
#' @return An object of class \code{metabias}, which is list with four elements:
#' \describe{
#'   \item{data}{A tibble with one row per study and the columns \code{yi},
#'               \code{vi}, \code{sei}, and \code{affirm} (logical indicating
#'               whether the study result is affirmative).}
#'   \item{values}{A vector with the elements \code{k} (number of studies),
#'                 \code{k_affirmative} (number of affirmative studies),
#'                 \code{k_nonaffirmative} (number of nonaffirmative studies),
#'                 \code{favor_positive} (as passed to \code{phacking_rtma()}),
#'                 \code{alpha_select} (as passed to \code{phacking_rtma()}),
#'                 \code{tcrit} (critical t-value based on \code{alpha_select}),
#'                 and \code{optim_converged} (logical indicating whether the
#'                 optimization to find the posterior mode converged).}
#'   \item{stats}{A tibble with two rows and the columns \code{param} (mu, tau),
#'                \code{mode}, \code{median}, \code{mean}, \code{se},
#'                \code{ci_lower}, \code{ci_upper}, \code{n_eff}, and
#'                \code{r_hat}. We recommend reporting the \code{mode} for the
#'                point estimate; \code{median} and \code{mean} represent
#'                posterior medians and means respectively.}
#'   \item{fit}{A \code{stanfit} object (the result of fitting the RTMA model).}
#' }
#'
#' @export
#'
#' @references
#' \insertRef{mathur2022}{phacking}
#'
#' @examples
#' \donttest{
#' set.seed(22)
#' phacking_rtma(lodder$yi, lodder$vi, parallelize = FALSE)
#' }
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
  if (length(sei) != length(yi)) stop(
    "Length of 'vi' or 'sei' must match that of 'yi'."
  )
  if (any(sei < 0)) stop("vi or sei should never be negative.")

  k <- length(yi)
  tcrit <- qnorm(1 - alpha_select / 2)
  affirm <- (yi / sei) > tcrit
  k_nonaffirm <- sum(!affirm)
  if (k_nonaffirm == 0) stop(
    "Dataset must contain at least one nonaffirmative study to fit RTMA."
  )

  dat <- tibble(yi = yi, vi = vi, sei = sei, affirm = affirm)
  nonaffirm <- dat %>% filter(!affirm)
  stan_data <- list(y = array(nonaffirm$yi), sei = array(nonaffirm$sei),
                    k = k_nonaffirm, tcrit = array(rep(tcrit, k_nonaffirm)))

  vals <- list(k = k,
               k_affirmative = k - k_nonaffirm,
               k_nonaffirmative = k_nonaffirm,
               favor_positive = favor_positive,
               alpha_select = alpha_select,
               tcrit = tcrit)

  if (parallelize) options(mc.cores = parallel::detectCores())
  stan_fit <- rstan::sampling(stanmodels$phacking_rtma,
                              data = stan_data,
                              control = stan_control,
                              init = function() list(mu = 0, tau = 1))

  stan_extract <- rstan::extract(stan_fit)
  medians <- c(median(stan_extract$mu), median(stan_extract$tau))

  index_maxlp <- which.max(stan_extract$log_post)
  mu_maxlp <- stan_extract$mu[index_maxlp]
  tau_maxlp <- stan_extract$tau[index_maxlp]
  mle_fit <- mle_params(mu_maxlp, tau_maxlp, nonaffirm$yi, nonaffirm$sei, tcrit)
  modes <- c(mle_fit@coef[["mu"]], mle_fit@coef[["tau"]])
  optim_converged <- mle_fit@details$convergence == 0
  vals$optim_converged <- optim_converged

  stan_summary <- rstan::summary(stan_fit)$summary %>%
    as_tibble(rownames = "param")

  stan_stats <- stan_summary %>%
    filter(.data$param %in% c("mu", "tau")) %>%
    select(.data$param, .data$mean, se = .data$se_mean, ci_lower = .data$`2.5%`,
           ci_upper = .data$`97.5%`, .data$n_eff, r_hat = .data$Rhat) %>%
    mutate(mode = modes, median = medians, .after = .data$param)

  results <- list(data = dat, values = vals, stats = stan_stats, fit = stan_fit)
  class(results) <- "metabias"
  return(results)

}
