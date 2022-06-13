test_that("symmetry wrt favor_positive", {
  lodder <- lodder_sub()

  lodder$yi_flipped <- -lodder$yi

  res1 <- phacking_rtma(lodder$yi, lodder$vi, parallelize = FALSE)
  res2 <- phacking_rtma(lodder$yi_flipped, lodder$vi, parallelize = FALSE,
                        favor_positive = FALSE)

  expect_equal(res1$stats$mode, res2$stats$mode, tolerance = 0.01)
})
