#' Meta-analysis of money priming studies
#'
#' Dataset from a meta-analysis of experimental studies on the effect of money
#' primes on a variety of psychological and behavioral outcomes, in which some
#' studies were preregistered \insertCite{lodder2019}{metabias}.
#'
#' @docType data
#'
#' @format A data frame with 287 rows and 4 variables:
#' \describe{
#'   \item{study}{Code identifying the study}
#'   \item{yi}{Point estimate on the Hedges' *g* scale}
#'   \item{vi}{Variance of point estimate}
#'   \item{zi}{Z-score}
#'   \item{preregistered}{Logical indicating whether study was preregistered}
#' }
#'
#' @references
#' \insertRef{lodder2019}{metabias}
#'
#' \insertRef{lodder2020}{metabias}
"money_priming_meta"
