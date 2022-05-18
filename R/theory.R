#' @keywords internal
get_lprior <- function(mu, tau, sei, tcrit) {
  e_fisher_i <- function(se) {
    si <- sqrt(tau ^ 2 + se ^ 2)
    cz <- (tcrit * se - mu) / si
    r <- dnorm(cz) / pnorm(cz)

    kmm <- si ^ (-2) * (cz * r + r ^ 2 - 1)
    kms <- tau * si ^ (-3) * r * (cz ^ 2 + cz * r + 1)
    kss <- tau ^ 2 * si ^ (-4) * (cz ^ 3 * r + cz ^ 2 * r ^ 2 + cz * r - 2)

    matrix(c(-kmm, -kms, -kms, -kss), nrow = 2, ncol = 2)
  }

  e_fisher <- purrr::map(sei, e_fisher_i) %>% purrr::reduce(`+`)
  log(sqrt(det(e_fisher)))
}

#' @keywords internal
get_nll <- function(mu, tau, yi, sei, tcrit) {
  si <- sqrt(tau ^ 2 + sei ^ 2)
  cz <- (tcrit * sei - mu) / si
  sum(log(si * sqrt(2 * pi)) + 0.5 * si ^ (-2) * (yi - mu) ^ 2 + log(pnorm(cz)))
}

#' @keywords internal
nlpost_rtma <- function(mu, tau, yi, sei, tcrit) {
  joint_nll <- get_nll(mu, tau, yi, sei, tcrit) # negative log-likelihood
  joint_lprior <- get_lprior(mu, tau, sei, tcrit) # log-prior
  joint_nll - joint_lprior # log-posterior
}

#' @keywords internal
mle_params <- function(mu_start, tau_start, yi, sei, tcrit) {
  nlpost_fun <- function(mu, tau) nlpost_rtma(mu, tau, yi, sei, tcrit)
  stats4::mle(minuslogl = nlpost_fun,
              start = list(mu = mu_start, tau = tau_start),
              method = "Nelder-Mead")
}
