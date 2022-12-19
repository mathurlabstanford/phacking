#' @keywords internal
#' @references
#' \insertRef{mathur2022phacking}{metabias}
#'
#' \insertRef{lodder2019}{metabias}
#'
#' \insertRef{stan2022}{metabias}
"_PACKAGE"

## usethis namespace: start
#' @useDynLib phacking, .registration = TRUE
#' @import ggplot2
#' @import methods
#' @import Rcpp
#' @importFrom dplyr as_tibble filter if_else mutate pull rowwise select tibble
#' @importFrom Rdpack reprompt
#' @importFrom rlang .data
#' @importFrom rstan sampling
#' @importFrom stats dnorm ecdf median pnorm qnorm quantile
## usethis namespace: end
NULL

#' @keywords internal
money_priming_sub <- function() phacking::money_priming_meta[1:50, ]
