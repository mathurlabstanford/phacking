test_that("stan respects changes to control parameters", {
  lodder <- lodder_sub()

  res <- phacking_rtma(lodder$yi, lodder$vi, alpha_select = 1e-10,
                       parallelize = FALSE,
                       stan_control = list(adapt_delta = 0.7,
                                           max_treedepth = 10))


  expect_equal(0.7, attr(res$fit, "stan_args")[[4]]$control$adapt_delta)
  expect_equal(attr(res$fit, "stan_args")[[4]]$control$max_treedepth, 10)
})

test_that("study counts are right even with a strange alpha_select", {
  lodder <- lodder_sub()
  alpha <- 1e-10
  z_alpha <- qnorm(1 - alpha / 2)
  lodder$my_affirm <- lodder$yi / sqrt(lodder$vi) > z_alpha
  res <- phacking_rtma(lodder$yi, lodder$vi, alpha_select = alpha,
                       parallelize = FALSE)

  expect_equal(nrow(lodder), res$values$k)
  expect_equal(sum(lodder$my_affirm), res$values$k_affirmative)
  expect_equal(sum(lodder$my_affirm == 0), res$values$k_nonaffirmative)
  expect_equal(z_alpha, res$values$tcrit)
})

test_that("one nonaffirmative runs", {
  # try passing only 1 nonaffirmative; should still run but have warnings
  w <- capture_warnings(phacking_rtma(yi = 0.2, sei = 0.2, parallelize = FALSE))
  expect_gt(length(w), 0)
})
