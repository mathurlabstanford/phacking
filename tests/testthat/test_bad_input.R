test_that("catch bad inputs", {
  lodder <- lodder_sub()

  # passing only affirmatives should result in an informative error
  lodder$my_affirm <- lodder$yi / sqrt(lodder$vi) > qnorm(.975)
  da <- lodder %>% filter(my_affirm)
  expect_error(phacking_rtma(da$yi, da$vi, parallelize = FALSE))

  # passing sei or vi vector whose length doesn't match yi should throw error
  expect_error(phacking_rtma(da$yi, 2, parallelize = FALSE))

  # passing negative sei should result in error
  expect_error(phacking_rtma(da$yi, sei = -sqrt(da$vi), parallelize = FALSE))
})
