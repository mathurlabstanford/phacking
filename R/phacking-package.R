#' @keywords internal
#' @references
#' \insertRef{mathur2022}{phacking}
#'
#' \insertRef{lodder2019}{phacking}
#'
#' \insertRef{stan2022}{phacking}
"_PACKAGE"

## usethis namespace: start
#' @useDynLib phacking, .registration = TRUE
#' @import methods
#' @import Rcpp
#' @import ggplot2
#' @importFrom rstan sampling
#' @importFrom stats dnorm ecdf median pnorm qnorm
#' @importFrom dplyr %>% as_tibble filter if_else mutate pull rowwise select
#'   tibble
#' @importFrom rlang .data
#' @importFrom Rdpack reprompt
## usethis namespace: end
NULL

#' @keywords internal
lodder_sub <- function() phacking::lodder[1:50, ]
