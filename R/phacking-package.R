#' The 'phacking' package.
#'
#' @description Methods for meta-analysis corrected for phacking.
#'
#' @docType package
#' @name phacking-package
#' @aliases phacking
#' @useDynLib phacking, .registration = TRUE
#' @import methods
#' @import Rcpp
#' @importFrom rstan sampling
#'
#' @importFrom stats dnorm ecdf median pnorm qnorm
#' @importFrom dplyr %>% as_tibble filter if_else mutate pull rowwise select
#'   tibble
#' @import ggplot2
#' @importFrom rlang .data
#'
#' @references Stan Development Team (2022). RStan: the R interface to Stan. R
#'   package version 2.21.5. https://mc-stan.org
#'
NULL
