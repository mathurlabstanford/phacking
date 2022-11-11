test_that("catch bad inputs", {
  mpm <- money_priming_sub()

  # passing only affirmatives should result in an informative error
  mpm <- mpm |> mutate(affirm = yi / sqrt(vi) > qnorm(.975))
  aff <- mpm |> filter(affirm)
  expect_error(phacking_meta(aff$yi, aff$vi, parallelize = FALSE))

  # passing sei or vi vector whose length doesn't match yi should throw error
  expect_error(phacking_meta(mpm$yi, 2, parallelize = FALSE))

  # passing negative sei should result in error
  expect_error(phacking_meta(mpm$yi, sei = -sqrt(mpm$vi), parallelize = FALSE))
})
