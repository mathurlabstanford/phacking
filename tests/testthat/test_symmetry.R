test_that("symmetry wrt favor_positive", {
  mpm <- money_priming_sub()

  mpm <- mpm |> mutate(yi_flipped = -yi)

  res1 <- phacking_meta(mpm$yi, mpm$vi, parallelize = FALSE)
  res2 <- phacking_meta(mpm$yi_flipped, mpm$vi, parallelize = FALSE,
                        favor_positive = FALSE)

  expect_equal(res1$stats$mode, res2$stats$mode, tolerance = 0.01)
})
