#' Compute theoretical and empirical CDFs for a right-truncated meta-analysis
#'
#' @param rtma Output of \code{phacking_rtma()}.
#'
#' @return A tibble with the columns \code{yi} (effect sizes), \code{cdfi}
#'   (their fitted CDF) and \code{ecdfi} (their empirical CDF).
#' @export
#'
#' @references
#' \insertRef{mathur2022}{phacking}
#'
#' @examples
#' \donttest{
#' set.seed(22)
#' lodder_rtma <- phacking_rtma(lodder$yi, lodder$vi, parallelize = FALSE)
#' rtma_cdf(lodder_rtma)
#' }
rtma_cdf <- function(rtma) {
  mu <- rtma$stats %>% filter(.data$param == "mu") %>% pull(.data$median)
  tau <- rtma$stats %>% filter(.data$param == "tau") %>% pull(.data$median)
  tcrit <- rtma$values$tcrit
  ptrunc <- truncnorm::ptruncnorm

  rtma$data %>%
    filter(!.data$affirm) %>%
    mutate(ecdfi = ecdf(.data$yi)(.data$yi),
           cdfi = ptrunc(q = .data$yi, a = -Inf, b = tcrit * .data$sei,
                         mean = mu, sd = sqrt(tau ^ 2 + .data$sei ^ 2))) %>%
    select(.data$yi, .data$cdfi, .data$ecdfi)
}

#' Diagnostic quantile-quantile plot for a right-truncated meta-analysis
#'
#' To assess the fit of right-truncated meta-analysis and possible violations of
#' its distributional assumptions, plots the fitted cumulative distribution
#' function (CDF) of the published nonaffirmative estimates versus their
#' empirical CDF. If the points do not adhere fairly closely to a 45-degree
#' line, the right-truncated meta-analysis may not fit adequately.
#' @param rtma Output of \code{phacking_rtma()}.
#' @return No return value, draws a plot.
#'
#' @export
#'
#' @examples
#' \donttest{
#' set.seed(22)
#' lodder_rtma <- phacking_rtma(lodder$yi, lodder$vi, parallelize = FALSE)
#' rtma_qqplot(lodder_rtma)
#' }
rtma_qqplot <- function(rtma) {
  cdf <- rtma_cdf(rtma)
  ggplot(cdf, aes(x = .data$cdfi, y = .data$ecdfi)) +
    coord_equal() +
    geom_abline() +
    geom_point(size = 2, alpha = 0.5) +
    labs(x = "Fitted CDF of point estimates",
         y = "Empirical CDF of point estimates") +
    theme_minimal()
}

#' Z-score density plot
#'
#' Plots the Z-scores of all published point estimates. When p-hacking favors
#' affirmative estimates over nonaffirmative estimates, as our methods and
#' others assume, Z-scores may disproportionately concentrate just above the
#' critical value (e.g., 1.96). Importantly, the presence of p-hacking does not
#' \emph{guarantee} a concentration of Z-scores just above the critical value,
#' so it is prudent to proceed with the fitting RTMA even if no such
#' concentration is apparent. In contrast, if Z-scores also concentrate just
#' \emph{below} the critical value, or if they also concentrate below the
#' sign-reversed critical value (e.g., -1.96), this could indicate forms of
#' p-hacking that violate the assumptions of RTMA.
#'
#' @inheritParams phacking_rtma
#' @param crit_color Color for line and text are critical z-score.
#' @return No return value, draws a plot.
#'
#' @export
#'
#' @examples
#' z_density(lodder$yi, lodder$vi)
z_density <- function(yi, vi, sei, alpha_select = 0.05, crit_color = "red") {

  if (missing(vi) & missing(sei)) stop("Must specify 'vi' or 'sei' argument.")
  if (missing(vi)) vi <- sei ^ 2
  if (missing(sei)) sei <- sqrt(vi)

  tcrit <- qnorm(1 - alpha_select / 2)
  qplot(yi / sei, geom = "density", adjust = 0.3) +
    geom_vline(xintercept = 0, color = "gray") +
    geom_vline(xintercept = tcrit, linetype = "dashed", color = crit_color) +
    annotate(geom = "text", label = sprintf("Z = %.2f", tcrit), x = tcrit - 0.2,
             y = 0, hjust = 0, color = crit_color, angle = 90) +
    scale_x_continuous(breaks = seq(-20, 20, 1), name = "Z-score") +
    scale_y_continuous(breaks = NULL, name = "") +
    theme_minimal()
}
