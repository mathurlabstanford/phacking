test_that("get_nll agrees with other package for truncated normal likelihood", {
  ours <- get_nll(mu = 1.2, tau = 0.23, yi = 0.25, sei = 0.2, tcrit = 1.96)
  check <- -log(truncnorm::dtruncnorm(x = 0.25,
                                      mean = 1.2,
                                      sd = sqrt(0.23 ^ 2 + 0.2 ^ 2),
                                      a = -Inf,
                                      b = 0.2 * 1.96))
  expect_equal(ours, check)
})
