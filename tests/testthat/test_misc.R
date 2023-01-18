test_that("stan respects changes to control parameters", {
  mpm <- money_priming_sub()

  res <- phacking_meta(mpm$yi, mpm$vi, alpha_select = 1e-10,
                       parallelize = FALSE,
                       stan_control = list(adapt_delta = 0.7,
                                           max_treedepth = 10))


  expect_equal(0.7, attr(res$fit, "stan_args")[[4]]$control$adapt_delta)
  expect_equal(attr(res$fit, "stan_args")[[4]]$control$max_treedepth, 10)
})

test_that("study counts are right even with a strange alpha_select", {
  mpm <- money_priming_sub()
  alpha <- 1e-10
  z_alpha <- qnorm(1 - alpha / 2)
  mpm <- mpm |> mutate(affirm = yi / sqrt(vi) > z_alpha)
  res <- phacking_meta(mpm$yi, mpm$vi, alpha_select = alpha,
                       parallelize = FALSE)

  expect_equal(nrow(mpm), res$values$k)
  expect_equal(sum(mpm$affirm), res$values$k_affirmative)
  expect_equal(sum(mpm$affirm == 0), res$values$k_nonaffirmative)
})

test_that("one nonaffirmative runs", {
  # try passing only 1 nonaffirmative; should still run but have warnings
  w <- capture_warnings(phacking_meta(yi = 0.2, sei = 0.2, parallelize = FALSE))
  expect_gt(length(w), 0)
})
