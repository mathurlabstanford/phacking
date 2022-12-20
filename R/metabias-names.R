#' @keywords internal
meta_names <- function(component) {
  names_list <- list(
    data = c("yi", "vi", "sei", "affirm"),
    values = c("favor_positive", "alpha_select", "ci_level", "k",
               "k_affirmative", "k_nonaffirmative", "optim_converged"),
    stats = c("param", "mode", "median", "mean", "se", "ci_lower",
              "ci_upper", "n_eff", "r_hat"))
  names_list[[component]]
}

#' @keywords internal
meta_names_str <- function(component) {
  cnames <- meta_names(component)
  paste(paste0("`", cnames, "`"), collapse = ", ")
}
