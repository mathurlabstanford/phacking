#' Meta-analysis of money priming studies
#'
#' Dataset from a meta-analysis of experimental studies on the effect of money
#' primes on a variety of psychological and behavioral outcomes, in which some
#' studies were preregistered (Lodder et al., 2019).
#'
#' @format A data frame with 287 rows and 4 variables:
#' \describe{
#'   \item{study}{Code identifying the study}
#'   \item{yi}{Point estimate on the Hedges' \emph{g} scale}
#'   \item{vi}{Variance of point estimate}
#'   \item{zi}{Z-score}
#'   \item{preregistered}{Logical indicating whether study was preregistered}
#' }
#'
#' @source Lodder, Ong, & Grasman (2019). A comprehensive meta-analysis of money
#' priming. \emph{Journal of Experimental Psychology: General}, 148(4):688-712.
#' Dataset available from \url{https://osf.io/8xjct/} and reused with
#' permission.
"lodder"
