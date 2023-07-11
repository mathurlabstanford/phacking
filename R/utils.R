# Internal function to link to the rstantools namespace
# to avoid NOTE: Namespaces in Imports field not imported from
rstand_config <- function() {
    rstantools::rstan_config()
}

# Internal function to link to the RcppParallel namespace
# to avoid NOTE: Namespaces in Imports field not imported from
RcppParallelLibs <- function() {
    RcppParallel::RcppParallelLibs()
}
